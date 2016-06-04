/* Empiria® Web Application 2012 *****************************************************************************
*																																																						 *
*	 Solution  : Empiria® Web Application                         System   : Workplace Web Pages               *
*	 Namespace : Empiria.Web.UI                                   Assembly : Empiria.Web.UI.dll                *
*	 Type      : ObjectSearcher                                   Pattern  : Explorer Web Page                 *
*	 Date      : 23/Oct/2012                                      Version  : 5.0      Pattern version: 2.0     *
*																																																						 *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*																																																						 *
******************************************************** Copyright © La Vía Óntica, SC. México, 1994-2012. **/
using System;
using System.Web.UI;
using Empiria.Government.LandRegistration;
using Empiria.Government.LandRegistration.Transactions;
using Empiria.Government.LandRegistration.UI;
using Empiria.Presentation.Web;

namespace Empiria.Web.UI.LRS {

  public partial class RecordingEditor : WebPage {

    #region Fields

    protected LRSDocumentEditorControl oRecordingDocumentEditor = null;
    protected LRSTransaction transaction = null;
    private ObjectList<Recording> recordings = null;
    protected string OnLoadScript = String.Empty;

    #endregion Fields

    #region Protected methods

    protected void Page_Init(object sender, EventArgs e) {
      LoadDocumentEditorControl();
    }

    private void LoadDocumentEditorControl() {
      oRecordingDocumentEditor = (LRSDocumentEditorControl) Page.LoadControl(LRSDocumentEditorControl.ControlVirtualPath);
      spanRecordingDocumentEditor.Controls.Add(oRecordingDocumentEditor);
    }

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (!IsPostBack) {
        LoadEditor();
      } else {
        ExecuteCommand();
      }
    }

    #endregion Protected methods

    #region Private methods

    private void ExecuteCommand() {
      switch (base.CommandName) {
        case "saveDocument":
          SaveDocument();
          SetRefreshPageScript();
          return;
        case "doBookRecording":
          DoBookRecording();
          SetRefreshPageScript();
          return;
        case "deleteBookRecording":
          DeleteBookRecording();
          SetRefreshPageScript();
          return;
        case "redirectMe":
          Response.Redirect("recording.editor.aspx?transactionId=" + transaction.Id.ToString(), true);
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    private void DoBookRecording() {
      Assertion.Require(transaction != null && !transaction.IsEmptyInstance,
                        "Transaction cant' be null or an empty instance.");
      Assertion.Require(transaction.Document != null && !transaction.Document.IsEmptyInstance,
                        "Document can't be empty instance.");

      RecorderOffice office = RecorderOffice.Parse(int.Parse(cboRecordingOffice.Value));
      RecordingActTypeCategory section = RecordingActTypeCategory.Parse(int.Parse(cboRecordingSection.Value));

      RecordingBook book = RecordingBook.GetAssignedBookForRecording(office, section, transaction.Document);
      Recording rec = book.CreateRecording(transaction, transaction.Document);
      SetMessageBox("Se agregó la " + rec.FullNumber + " al documento.");
    }

    private ObjectList<Recording> GetRecordings() {
      if (recordings == null) {
        recordings = transaction.Document.GetRecordings(transaction);
      }
      return recordings;
    }

    protected bool IsReadyForEdition() {
      if (transaction.IsEmptyInstance) {
        return false;
      }
      if (!User.CanExecute("LRSTransaction.Register")) {
        return false;
      }
      if (transaction.Status == TransactionStatus.Recording || transaction.Status == TransactionStatus.Qualification) {
        return true;
      }
      return false;
    }

    protected bool IsReadyForPrintFinalSeal() {
      if (transaction.IsEmptyInstance || transaction.Document.IsEmptyInstance) {
        return false;
      }
      if (GetRecordings().Count == 0) {
        return false;
      }
      if (User.CanExecute("LRSTransaction.Register") || !User.CanExecute("LRSTransaction.DocumentSigner")) {
        return true;
      }
      return false;
    }

    protected bool IsReadyForPrintRecordingCover() {
      //if (transaction.IsEmptyInstance || transaction.Document.IsEmptyInstance) {
      //  return false;
      //}
      //if (User.CanExecute("LRSTransaction.Register") || !User.CanExecute("LRSTransaction.DocumentSafeguard")) {
      //  return true;
      //}  
      return false;
    }

    private void DeleteBookRecording() {
      int recordingId = int.Parse(GetCommandParameter("id", true));

      Recording recording = Recording.Parse(recordingId);
      recording.Cancel();
      SetMessageBox("Se canceló la " + recording.FullNumber);
    }

    private void SaveDocument() {
      oRecordingDocumentEditor.FillRecordingDocument(RecordingDocumentType.Parse(int.Parse(cboRecordingType.Value)));

      Assertion.Require(transaction != null && !transaction.IsEmptyInstance,
                        "Transaction cant' be null or an empty instance.");
      Assertion.Require(int.Parse(cboSheetsCount.Value) != 0 && decimal.Parse(cboSealPosition.Value) != 0,
                        "Document sheets count or seal position has invalid data.");
      Assertion.Require(oRecordingDocumentEditor != null && !oRecordingDocumentEditor.Document.IsEmptyInstance,
                        "Recording document can't be null or an empty instance.");
      transaction.Document = oRecordingDocumentEditor.Document;
      transaction.Document.Notes = txtObservations.Value;
      transaction.Document.SheetsCount = int.Parse(cboSheetsCount.Value);
      transaction.Document.SealUpperPosition = decimal.Parse(cboSealPosition.Value);
      transaction.Document.Save();
      transaction.Save();
      oRecordingDocumentEditor.Document = transaction.Document;
      SetMessageBox("El documento " + transaction.Document.DocumentKey + " se guardó correctamente.");
    }

    private void Initialize() {
      int transactionId = int.Parse(Request.QueryString["transactionId"]);
      if (transactionId != 0) {
        transaction = LRSTransaction.Parse(transactionId);
      } else {
        transaction = LRSTransaction.Empty;
      }
      oRecordingDocumentEditor.Document = transaction.Document;
    }

    private void LoadEditor() {
      cboRecordingType.Value = transaction.Document.RecordingDocumentType.Id.ToString();
      oRecordingDocumentEditor.LoadRecordingDocument();
      txtObservations.Value = transaction.Document.Notes;
      cboSheetsCount.Value = transaction.Document.SheetsCount.ToString();
      cboSealPosition.Value = transaction.Document.SealUpperPosition.ToString("N1");
    }

    protected string GetDocumentRecordings() {
      const string row = "<tr class='{CLASS}' valign='top'>" +
                         "<td style='white-space:nowrap;'><img src='../themes/default/buttons/document.sm.gif' alt='' title='Imprime el sello específico para esta partida' onclick='return doOperation(\"viewRecordingSeal\", {ID})' /> Sello partida</td>" +
                         "<td style='white-space:nowrap;'>Número</td><td>{DATE}</td><td style='white-space:nowrap;'>{DISTRICT}</td><td style='white-space:nowrap;'>{SECTION}</td>" +
                         "<td><a href='javascript:doOperation(\"viewRecordingBookIndex\", {ID})'>{VOLUME}</a></td><td>{NUMBER}</td><td style='width:50%'>{REGISTER}</td>" +
                         "<td align='center'><img src='../themes/default/buttons/trash.gif' alt='' onclick='return doOperation(\"deleteBookRecording\", {ID})' /></td></tr>";

      ObjectList<Recording> recordings = GetRecordings();

      string html = String.Empty;
      for (int i = 0; i < recordings.Count; i++) {
        string temp = row.Replace("{CLASS}", ((i % 2) == 0) ? "detailsItem" : "detailsOddItem");
        temp = temp.Replace("{ID}", recordings[i].Id.ToString());
        temp = temp.Replace("{DATE}", recordings[i].AuthorizedTime.ToString("dd/MMM/yyyy HH:mm"));
        temp = temp.Replace("{DISTRICT}", recordings[i].RecordingBook.RecorderOffice.Alias);
        temp = temp.Replace("{SECTION}", recordings[i].RecordingBook.RecordingsClass.Name);
        temp = temp.Replace("{VOLUME}", recordings[i].RecordingBook.Name);
        temp = temp.Replace("{NUMBER}", recordings[i].Number);
        temp = temp.Replace("{REGISTER}", recordings[i].CapturedBy.Alias);
        html += temp;
      }
      return html;
    }

    private void SetMessageBox(string msg) {
      OnLoadScript += "alert('" + msg + "');";
    }

    private void SetRefreshPageScript() {
      OnLoadScript += "sendPageCommand('redirectMe');";
    }

    #endregion Private methods

  } // class PropertyEditor

} // namespace Empiria.Web.UI.LRS