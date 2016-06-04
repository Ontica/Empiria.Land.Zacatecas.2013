/* Empiria� Web Application 2012 *****************************************************************************
*																																																						 *
*	 Solution  : Empiria� Web Application                         System   : Workplace Web Pages               *
*	 Namespace : Empiria.Web.UI                                   Assembly : Empiria.Web.UI.dll                *
*	 Type      : ObjectSearcher                                   Pattern  : Explorer Web Page                 *
*	 Date      : 23/Oct/2012                                      Version  : 5.0      Pattern version: 2.0     *
*																																																						 *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*																																																						 *
******************************************************** Copyright � La V�a �ntica, SC. M�xico, 1994-2012. **/
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Empiria.Contacts;
using Empiria.Government.LandRegistration;
using Empiria.Government.LandRegistration.UI;
using Empiria.Presentation;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

namespace Empiria.Web.UI.LRS {

  public partial class RecordingBookAnalyzer : WebPage {

    #region Fields

    protected LRSDocumentEditorControl oRecordingDocumentEditor = null;
    protected LRSDocumentEditorControl oAnnotationDocumentEditor = null;
    protected RecordingBook recordingBook = null;
    protected Recording recording = null;
    protected int currentImagePosition = 0;
    protected string gRecordingActs = String.Empty;
    protected string gAnnotationActs = String.Empty;
    protected int currentImageWidth = 1336;
    protected int currentImageHeight = 994;
    protected int recordingsPerViewerPage = 25;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Init(object sender, EventArgs e) {
      LoadDocumentEditorControl();
    }

    private void LoadDocumentEditorControl() {
      oRecordingDocumentEditor = (LRSDocumentEditorControl) Page.LoadControl(LRSDocumentEditorControl.ControlVirtualPath);
      spanRecordingDocumentEditor.Controls.Add(oRecordingDocumentEditor);

      oAnnotationDocumentEditor = (LRSDocumentEditorControl) Page.LoadControl(LRSDocumentEditorControl.ControlVirtualPath);
      spanAnnotationDocumentEditor.Controls.Add(oAnnotationDocumentEditor);
    }

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (IsPostBack) {
        DoCommand();
      } else {
        LoadControls();
      }
      hdnCurrentImagePosition.Value = currentImagePosition.ToString();
    }

    private void LoadRecordingBooksCombo() {
      cboRecordingBookSelector.Items.Clear();
      cboRecordingBookSelector.Items.Add(new ListItem("Libro Ra�z", recording.Id.ToString()));

      ObjectList<PropertyEvent> annotations = recording.GetPropertiesAnnotationsList();
      for (int i = 0; i < annotations.Count; i++) {
        cboRecordingBookSelector.Items.Add(new ListItem(Char.ConvertFromUtf32(65 + i),
                                           annotations[i].RecordingAct.Recording.Id.ToString()));
      }
      if (RecordingBook.UseBookAttachments) {
        RecordingAttachmentFolderList attachmentFolders = recording.GetAttachmentFolderList();
        if (attachmentFolders.Count != 0) {
          cboRecordingBookSelector.Items.Add(new ListItem("( Ap�ndices )", String.Empty));
        }
        foreach (RecordingAttachmentFolder folder in attachmentFolders) {
          cboRecordingBookSelector.Items.Add(new ListItem(folder.Alias,
                                             "&attachment=true&name=" + folder.Name +
                                             "&recordingId=" + folder.Recording.Id.ToString()));
        }
      }
    }

    private void LoadControls() {
      cboRecordingType.Value = recording.RecordingDocument.RecordingDocumentType.Id.ToString();
      oRecordingDocumentEditor.LoadRecordingDocument();
      oAnnotationDocumentEditor.LoadRecordingDocument();
      LoadRecordingBooksCombo();
      LoadRecordingActTypeCategoriesCombo();
      LoadAnnotationActsCategoriesCombo();
      LoadRecorderOfficersCombo();
      if (recording.Id > 0) {
        LoadRecordingControls();
      } else {
        LoadAnotherPropertyRecorderOfficesCombo();
        cboStatus.Disabled = true;
      }
      LoadRecordingViewerPagesCombo();
    }

    private void DoCommand() {
      switch (base.CommandName) {
        case "saveRecording":
          switch ((RecordingStatus) Convert.ToChar(cboStatus.Value)) {
            case RecordingStatus.NoLegible:
              RegisterAsNoLegibleRecording(false);
              RefreshPage();
              return;
            case RecordingStatus.Obsolete:
              RegisterAsObsoleteRecording(false);
              RefreshPage();
              return;
            case RecordingStatus.Pending:
              RegisterAsPendingRecording(false);
              RefreshPage();
              return;
            case RecordingStatus.Incomplete:
              RegisterAsIncompleteRecording(false);
              RefreshPage();
              return;
          }
          return;
        case "registerAsNoLegibleRecording":
          RegisterAsNoLegibleRecording(true);
          RefreshPage();
          return;
        case "appendRecordingAct":
          AppendRecordingAct();
          RefreshPage();
          return;
        case "registerAsObsoleteRecording":
          RegisterAsObsoleteRecording(true);
          RefreshPage();
          return;
        case "registerAsPendingRecording":
          RegisterAsPendingRecording(true);
          RefreshPage();
          return;
        case "registerAsIncompleteRecording":
          RegisterAsIncompleteRecording(true);
          RefreshPage();
          return;
        case "appendAnnotation":
          AppendAnnotation();
          RefreshPage();
          return;
        case "appendNoLegibleAnnotation":
          AppendNoLegibleAnnotation();
          RefreshPage();
          return;
        case "newRecording":
          Response.Redirect("recording.book.analyzer.aspx?bookId=" + recordingBook.Id.ToString() + "&id=-1&image=" + hdnCurrentImagePosition.Value);
          return;
        case "deleteRecording":
          DeleteRecording();
          Response.Redirect("recording.book.analyzer.aspx?bookId=" + recordingBook.Id.ToString() + "&id=0&image=" + hdnCurrentImagePosition.Value, true);
          return;
        case "appendPropertyToAnnotation":
          AppendPropertyToAnnotation();
          RefreshPage();
          return;
        case "appendPropertyToRecordingAct":
          AppendPropertyToRecordingAct();
          RefreshPage();
          return;
        case "modifyRecordingActType":
          ModifyRecordingActType();
          RefreshPage();
          return;
        case "deleteRecordingAct":
          DeleteRecordingAct();
          RefreshPage();
          return;
        case "deleteRecordingActProperty":
          DeleteRecordingActProperty();
          RefreshPage();
          return;
        case "upwardRecordingAct":
          UpwardRecordingAct();
          RefreshPage();
          return;
        case "downwardRecordingAct":
          DownwardRecordingAct();
          RefreshPage();
          return;
        case "deleteAnnotation":
          DeleteAnnotation();
          RefreshPage();
          return;
        case "gotoRecording":
          GoToRecording();
          Response.Redirect("recording.book.analyzer.aspx?bookId=" + recordingBook.Id.ToString() + "&id=" + recording.Id.ToString(), true);
          return;
        case "moveToRecording":
          MoveToRecording();
          Response.Redirect("recording.book.analyzer.aspx?bookId=" + recordingBook.Id.ToString() + "&id=" + recording.Id.ToString(), true);
          return;
        case "gotoImage":
          MoveToImage(txtGoToImage.Value);
          return;
        case "insertEmptyImageBefore":
          InsertEmptyImageBefore();
          Response.Redirect("recording.book.analyzer.aspx?bookId=" + recordingBook.Id.ToString() + "&id=0&image=" + hdnCurrentImagePosition.Value, true);
          return;
        case "deleteImage":
          DeleteImage();
          Response.Redirect("recording.book.analyzer.aspx?bookId=" + recordingBook.Id.ToString() + "&id=0&image=" + hdnCurrentImagePosition.Value, true);
          return;
        case "refreshImagesStatistics":
          RefreshImagesStatistics();
          RefreshPage();
          return;
        case "refresh":
          this.recordingBook.Refresh();
          RefreshPage();
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    #endregion Constructors and parsers

    #region Private methods

    private void RefreshPage() {
      Response.Redirect("recording.book.analyzer.aspx?bookId=" + recordingBook.Id.ToString() + "&id=" + recording.Id.ToString() + "&image=" + hdnCurrentImagePosition.Value, true);
    }

    private void LoadRecordingControls() {
      oRecordingPaymentEditorControl.LoadRecordingMainPayment();
      txtRecordingNumber.Value = recording.NumberPrefix;
      chkUseBisRecordingNumber.Checked = recording.UseBisNumberTag;
      txtImageStartIndex.Value = recording.StartImageIndex.ToString();
      txtImageEndIndex.Value = recording.EndImageIndex.ToString();

      cboRecordingActTypeCategory.Value = "0";
      if (recording.PresentationTime.Date != ExecutionServer.DateMaxValue) {
        txtPresentationDate.Value = recording.PresentationTime.ToString("dd/MMM/yyyy");
        txtPresentationTime.Value = recording.PresentationTime.ToString("HH:mm");
      }
      if (recording.AuthorizedTime.Date != ExecutionServer.DateMaxValue) {
        txtAuthorizationDate.Value = recording.AuthorizedTime.ToString("dd/MMM/yyyy");
      }
      cboAuthorizedBy.Value = recording.AuthorizedBy.Id.ToString();

      LoadStatusCombo();
      cboStatus.Value = ((char) recording.Status).ToString();
      txtObservations.Value = recording.Notes;

      cboAnnotationCategory.Value = "0";

      gRecordingActs = LRSGridControls.GetBatchCaptureRecordingActsGrid(this.recording);
      gAnnotationActs = LRSGridControls.GetRecordingAnnotationsGrid(this.recording);
      LoadRecordingActsPropertiesCombo();
      LoadAnotherPropertyRecorderOfficesCombo();
      LoadAnnotationsPropertiesCombo();
    }

    private void LoadAnotherPropertyRecorderOfficesCombo() {
      LRSHtmlSelectControls.LoadRecorderOfficeCombo(this.cboAnotherRecorderOffice, ComboControlUseMode.ObjectCreation,
                                                    recordingBook.RecorderOffice);

      ObjectList<RecordingBook> recordingBookList = recordingBook.RecorderOffice.GetTraslativeRecordingBooks();

      if (recordingBookList.Count != 0) {
        HtmlSelectContent.LoadCombo(this.cboAnotherRecordingBook, recordingBookList, "Id", "FullName",
                                    "( Seleccionar el libro registral donde se encuentra )", String.Empty, String.Empty);
      } else {
        HtmlSelectContent.LoadCombo(this.cboAnotherRecordingBook, "No existen libros de traslativo de dominio para el Distrito",
                                    String.Empty, String.Empty);
      }

      cboAnotherRecording.Items.Clear();
      cboAnotherRecording.Items.Add(new ListItem("�Libro?", String.Empty));

      cboAnotherProperty.Items.Clear();
      cboAnotherProperty.Items.Add(new ListItem("( �Inscripci�n? )", String.Empty));
    }

    private void LoadRecordingActsPropertiesCombo() {
      cboProperty.Items.Clear();
      if (recording.RecordingActs.Count != 0) {
        cboProperty.Items.Add(new ListItem("( Seleccionar )", ""));
      }
      for (int i = 0; i < recording.RecordingActs.Count; i++) {
        RecordingAct recordingAct = recording.RecordingActs[i];
        for (int j = 0; j < recordingAct.PropertiesEvents.Count; j++) {
          ListItem item = new ListItem(recordingAct.PropertiesEvents[j].Property.TractKey,
                                       recordingAct.PropertiesEvents[j].Property.Id.ToString());
          if (!cboProperty.Items.Contains(item)) {
            cboProperty.Items.Add(item);
          }
        }
      }
      cboProperty.Items.Add(new ListItem("Nuevo predio", "0"));
      cboProperty.Items.Add(new ListItem("Predio ya inscrito", "-1"));
    }

    private void LoadAnnotationsPropertiesCombo() {
      cboAnnotationProperty.Items.Clear();
      for (int i = 0; i < cboProperty.Items.Count - 1; i++) {
        cboAnnotationProperty.Items.Add(cboProperty.Items[i]);
      }
    }

    private void LoadStatusCombo() {
      cboStatus.Items.Clear();
      if (recording.Status == RecordingStatus.Closed) {
        cboStatus.Items.Add(new ListItem("Cerrada", ((char) RecordingStatus.Closed).ToString()));
        return;
      }
      if (recording.Status == RecordingStatus.Registered) {
        cboStatus.Items.Add(new ListItem("Registrada", ((char) RecordingStatus.Registered).ToString()));
        return;
      }
      if (recording.IsNew) {
        cboStatus.Items.Add(new ListItem(String.Empty, String.Empty));
      } else {
        cboStatus.Items.Add(new ListItem("No vigente", ((char) RecordingStatus.Obsolete).ToString()));
        cboStatus.Items.Add(new ListItem("No legible", ((char) RecordingStatus.NoLegible).ToString()));
        cboStatus.Items.Add(new ListItem("Pendiente", ((char) RecordingStatus.Pending).ToString()));
        if (recording.RecordingActs.Count != 0) {
          cboStatus.Items.Add(new ListItem("Incompleta", ((char) RecordingStatus.Incomplete).ToString()));
        }

      }
    }

    private void DeleteAnnotation() {
      int recordingActId = int.Parse(GetCommandParameter("recordingActId"));
      int propertyId = int.Parse(GetCommandParameter("propertyId"));

      RecordingAct recordingAct = RecordingAct.Parse(recordingActId);
      Property property = Property.Parse(propertyId);

      recordingAct.RemoveProperty(property);
    }

    private void DeleteImage() {
      recordingBook.DeleteImageAtIndex(int.Parse(hdnCurrentImagePosition.Value));
    }

    private void DeleteRecordingAct() {
      int recordingActId = int.Parse(GetCommandParameter("recordingActId"));

      RecordingAct recordingAct = recording.GetRecordingAct(recordingActId);

      recording.DeleteRecordingAct(recordingAct);
    }

    private void DeleteRecording() {
      int recordingId = int.Parse(GetCommandParameter("id"));

      if (recordingId != recording.Id) {
        return;
      }
      if (recording.GetPropertiesAnnotationsList().Count > 0) {
        return;
      }
      if (recording.RecordingActs.Count > 0) {
        return;
      }
      recording.Status = RecordingStatus.Deleted;
      recording.Save();

      this.recordingBook.Refresh();
    }

    private void DeleteRecordingActProperty() {
      int recordingActId = int.Parse(GetCommandParameter("recordingActId"));
      int propertyId = int.Parse(GetCommandParameter("propertyId"));

      RecordingAct recordingAct = this.recording.GetRecordingAct(recordingActId);
      Property property = Property.Parse(propertyId);
      recordingAct.RemoveProperty(property);
    }

    private void ModifyRecordingActType() {
      int recordingActId = int.Parse(GetCommandParameter("recordingActId"));
      int recordingActTypeId = int.Parse(Request.Form["cboRecordingActType"]);

      RecordingAct recordingAct = recording.GetRecordingAct(recordingActId);
      RecordingActType recordingActType = RecordingActType.Parse(recordingActTypeId);
      recordingAct.RecordingActType = recordingActType;
      recordingAct.Save();
    }

    private void InsertEmptyImageBefore() {
      recordingBook.InsertEmptyImageAtIndex(int.Parse(hdnCurrentImagePosition.Value));
    }

    private void RefreshImagesStatistics() {
      recordingBook.ImagingFilesFolder.RenameDirectoryImages();
      recordingBook.ImagingFilesFolder.UpdateStatistics();
      recordingBook.ImagingFilesFolder.Save();

      recordingBook.Refresh();
    }

    private void AppendPropertyToAnnotation() {
      int annotationId = int.Parse(GetCommandParameter("annotationId"));
      int propertyId = int.Parse(cboAnnotationProperty.Value);

      RecordingAct annotation = RecordingAct.Parse(annotationId);
      Property property = Property.Parse(propertyId);

      annotation.AppendPropertyEvent(property);
    }

    private void AppendPropertyToRecordingAct() {
      int recordingActId = int.Parse(GetCommandParameter("recordingActId"));

      RecordingAct recordingAct = recording.GetRecordingAct(recordingActId);

      recordingAct.AppendPropertyEvent(new Property());
    }

    private void UpwardRecordingAct() {
      int recordingActId = int.Parse(GetCommandParameter("recordingActId"));

      RecordingAct recordingAct = recording.GetRecordingAct(recordingActId);

      recording.UpwardRecordingAct(recordingAct);
    }

    private void DownwardRecordingAct() {
      int recordingActId = int.Parse(GetCommandParameter("recordingActId"));

      RecordingAct recordingAct = recording.GetRecordingAct(recordingActId);

      recording.DownwardRecordingAct(recordingAct);
    }

    private void RegisterAsNoLegibleRecording(bool appendMode) {
      if (appendMode) {
        this.recording = new Recording();
        oRecordingPaymentEditorControl.Recording = this.recording;
      }
      recording.RecordingBook = this.recordingBook;
      recording.UseBisNumberTag = chkUseBisRecordingNumber.Checked;
      recording.Number = txtRecordingNumber.Value;
      recording.Status = RecordingStatus.NoLegible;
      recording.StartImageIndex = int.Parse(txtImageStartIndex.Value);
      recording.EndImageIndex = int.Parse(txtImageEndIndex.Value);
      recording.Notes = txtObservations.Value;
      if (txtPresentationDate.Value.Length != 0 && txtPresentationTime.Value.Length != 0) {
        recording.PresentationTime = EmpiriaString.ToDateTime(txtPresentationDate.Value + " " + txtPresentationTime.Value);
      }
      if (txtAuthorizationDate.Value.Length != 0) {
        recording.AuthorizedTime = EmpiriaString.ToDate(txtAuthorizationDate.Value);
      }
      if (cboAuthorizedBy.Value.Length != 0) {
        recording.AuthorizedBy = Contact.Parse(int.Parse(cboAuthorizedBy.Value));
      }
      RecordingDocumentType documentType = RecordingDocumentType.Parse(int.Parse(cboRecordingType.Value));
      oRecordingDocumentEditor.FillRecordingDocument(documentType);
      recording.Save();
      oRecordingPaymentEditorControl.SaveRecordingMainPayment();

      this.recordingBook.Refresh();
    }

    private void RegisterAsObsoleteRecording(bool appendMode) {
      if (appendMode) {
        this.recording = new Recording();
        oRecordingPaymentEditorControl.Recording = this.recording;
      }
      recording.RecordingBook = this.recordingBook;
      recording.UseBisNumberTag = chkUseBisRecordingNumber.Checked;
      recording.Number = txtRecordingNumber.Value;
      recording.Status = RecordingStatus.Obsolete;
      recording.StartImageIndex = int.Parse(txtImageStartIndex.Value);
      recording.EndImageIndex = int.Parse(txtImageEndIndex.Value);
      recording.Notes = txtObservations.Value;
      if (txtPresentationDate.Value.Length != 0 && txtPresentationTime.Value.Length != 0) {
        recording.PresentationTime = EmpiriaString.ToDateTime(txtPresentationDate.Value + " " + txtPresentationTime.Value);
      }
      if (txtAuthorizationDate.Value.Length != 0) {
        recording.AuthorizedTime = EmpiriaString.ToDate(txtAuthorizationDate.Value);
      }
      if (cboAuthorizedBy.Value.Length != 0) {
        recording.AuthorizedBy = Contact.Parse(int.Parse(cboAuthorizedBy.Value));
      }
      oRecordingDocumentEditor.FillRecordingDocument(RecordingDocumentType.Parse(int.Parse(cboRecordingType.Value)));
      recording.Save();
      oRecordingPaymentEditorControl.SaveRecordingMainPayment();

      this.recordingBook.Refresh();
    }

    private void RegisterAsPendingRecording(bool appendMode) {
      if (appendMode) {
        this.recording = new Recording();
        oRecordingPaymentEditorControl.Recording = this.recording;
      }
      recording.RecordingBook = this.recordingBook;
      recording.UseBisNumberTag = chkUseBisRecordingNumber.Checked;
      recording.Number = txtRecordingNumber.Value;
      recording.Status = RecordingStatus.Pending;
      recording.StartImageIndex = int.Parse(txtImageStartIndex.Value);
      recording.EndImageIndex = int.Parse(txtImageEndIndex.Value);
      recording.PresentationTime = EmpiriaString.ToDateTime(txtPresentationDate.Value + " " + txtPresentationTime.Value);
      recording.AuthorizedTime = EmpiriaString.ToDate(txtAuthorizationDate.Value);
      recording.AuthorizedBy = Contact.Parse(int.Parse(cboAuthorizedBy.Value));
      recording.Notes = txtObservations.Value;
      oRecordingDocumentEditor.FillRecordingDocument(RecordingDocumentType.Parse(int.Parse(cboRecordingType.Value)));
      recording.Save();
      oRecordingPaymentEditorControl.SaveRecordingMainPayment();

      this.recordingBook.Refresh();
    }

    private void RegisterAsIncompleteRecording(bool appendRecordingAct) {
      recording.RecordingBook = this.recordingBook;
      recording.UseBisNumberTag = chkUseBisRecordingNumber.Checked;
      recording.Number = txtRecordingNumber.Value;
      recording.Status = RecordingStatus.Incomplete;
      recording.StartImageIndex = int.Parse(txtImageStartIndex.Value);
      recording.EndImageIndex = int.Parse(txtImageEndIndex.Value);
      recording.PresentationTime = EmpiriaString.ToDateTime(txtPresentationDate.Value + " " + txtPresentationTime.Value);
      recording.AuthorizedTime = EmpiriaString.ToDate(txtAuthorizationDate.Value);
      recording.AuthorizedBy = Contact.Parse(int.Parse(cboAuthorizedBy.Value));
      recording.Notes = txtObservations.Value;
      oRecordingDocumentEditor.FillRecordingDocument(RecordingDocumentType.Parse(int.Parse(cboRecordingType.Value)));
      recording.Save();
      oRecordingPaymentEditorControl.SaveRecordingMainPayment();
      if (appendRecordingAct) {
        AppendRecordingAct();
      }
      this.recordingBook.Refresh();
    }

    private void AppendRecordingAct() {
      int propertyId = int.Parse(cboProperty.Value);
      Property property = null;
      if (propertyId == 0) {
        property = new Property();
      } else if (propertyId == -1) {
        property = Property.Parse(int.Parse(Request.Form["cboAnotherProperty"]));
      } else {
        property = Property.Parse(propertyId);
      }
      RecordingActType recordingActType = RecordingActType.Parse(int.Parse(Request.Form["cboRecordingActType"]));
      recording.CreateRecordingAct(recordingActType, property);
    }

    private void AppendAnnotation() {
      Recording annotation = new Recording();

      oAnnotationPaymentEditorControl.Recording = annotation;
      annotation.RecordingBook = RecordingBook.Parse(int.Parse(Request.Form["cboAnnotationBook"]));
      annotation.UseBisNumberTag = chkUseBisAnnotationNumber.Checked;
      annotation.Number = txtAnnotationNumber.Value;
      annotation.Status = RecordingStatus.Incomplete;
      annotation.StartImageIndex = int.Parse(txtAnnotationImageStartIndex.Value);
      annotation.EndImageIndex = int.Parse(txtAnnotationImageEndIndex.Value);
      annotation.PresentationTime = EmpiriaString.ToDateTime(txtAnnotationPresentationDate.Value + " " + txtAnnotationPresentationTime.Value);
      annotation.AuthorizedTime = EmpiriaString.ToDate(txtAnnotationAuthorizationDate.Value);
      annotation.AuthorizedBy = Contact.Parse(int.Parse(Request.Form["cboAnnotationAuthorizedBy"]));
      annotation.Notes = txtAnnotationObservations.Value;
      oAnnotationDocumentEditor.Recording = annotation;
      oAnnotationDocumentEditor.FillRecordingDocument(RecordingDocumentType.Parse(int.Parse(cboAnnotationDocumentType.Value)));
      Property property = Property.Parse(int.Parse(cboAnnotationProperty.Value));
      RecordingActType annotationRecordingActType = RecordingActType.Parse(int.Parse(Request.Form["cboAnnotation"]));

      annotation.Save();
      oAnnotationPaymentEditorControl.SaveRecordingMainPayment();
      annotation.CreateRecordingAct(annotationRecordingActType, property);

      annotation.RecordingBook.Refresh();
    }

    private void AppendNoLegibleAnnotation() {
      Recording annotation = new Recording();
      oAnnotationPaymentEditorControl.Recording = annotation;
      annotation.RecordingBook = RecordingBook.Parse(int.Parse(Request.Form["cboAnnotationBook"]));
      annotation.UseBisNumberTag = chkUseBisAnnotationNumber.Checked;
      annotation.Number = txtAnnotationNumber.Value;
      annotation.Status = RecordingStatus.NoLegible;
      annotation.StartImageIndex = int.Parse(txtAnnotationImageStartIndex.Value);
      annotation.EndImageIndex = int.Parse(txtAnnotationImageEndIndex.Value);
      if (txtAnnotationPresentationTime.Value.Length != 0) {
        annotation.PresentationTime = EmpiriaString.ToDateTime(txtAnnotationPresentationDate.Value + " " + txtAnnotationPresentationTime.Value);
      } else if (txtAnnotationPresentationDate.Value.Length != 0) {
        annotation.PresentationTime = EmpiriaString.ToDate(txtAnnotationPresentationDate.Value);
      }
      if (txtAnnotationAuthorizationDate.Value.Length != 0) {
        annotation.AuthorizedTime = EmpiriaString.ToDate(txtAnnotationAuthorizationDate.Value);
      }
      if (Request.Form["cboAnnotationAuthorizedBy"].Length != 0) {
        annotation.AuthorizedBy = Contact.Parse(int.Parse(Request.Form["cboAnnotationAuthorizedBy"]));
      }
      annotation.Notes = txtAnnotationObservations.Value;
      oAnnotationDocumentEditor.Recording = annotation;
      oAnnotationDocumentEditor.FillRecordingDocument(RecordingDocumentType.Parse(int.Parse(cboAnnotationDocumentType.Value)));

      Property property = Property.Parse(int.Parse(cboAnnotationProperty.Value));
      RecordingActType annotationRecordingActType = RecordingActType.Parse(int.Parse(Request.Form["cboAnnotation"]));

      annotation.Save();
      oAnnotationPaymentEditorControl.SaveRecordingMainPayment();
      annotation.CreateRecordingAct(annotationRecordingActType, property);

      annotation.RecordingBook.Refresh();
    }

    private void CleanControls() {
      cboRecordingType.Value = String.Empty;
      cboStatus.Value = String.Empty;
      txtRecordingNumber.Value = String.Empty;
      chkUseBisRecordingNumber.Checked = false;
      txtImageStartIndex.Value = String.Empty;
      txtImageEndIndex.Value = String.Empty;

      cboRecordingActTypeCategory.Value = "0";
      txtPresentationDate.Value = String.Empty;
      txtPresentationTime.Value = String.Empty;
      txtAuthorizationDate.Value = String.Empty;
      cboAuthorizedBy.Value = String.Empty;
      txtObservations.Value = String.Empty;
      cboAnnotationCategory.Value = "0";
      txtAnnotationNumber.Value = String.Empty;
      chkUseBisAnnotationNumber.Checked = false;
      txtAnnotationImageStartIndex.Value = String.Empty;
      txtAnnotationImageEndIndex.Value = String.Empty;
      txtAnnotationPresentationDate.Value = String.Empty;
      txtAnnotationPresentationTime.Value = String.Empty;
      txtAnnotationAuthorizationDate.Value = String.Empty;
    }

    private void MoveToImage(string position) {
      switch (position) {
        case "First":
          currentImagePosition = 0;
          break;
        case "Previous":
          currentImagePosition = Math.Max(currentImagePosition - 1, 0);
          break;
        case "Next":
          currentImagePosition = Math.Min(currentImagePosition + 1, recordingBook.ImagingFilesFolder.FilesCount - 1);
          break;
        case "Last":
          currentImagePosition = recordingBook.ImagingFilesFolder.FilesCount - 1;
          break;
        default:
          currentImagePosition = int.Parse(position) - 1;
          break;
      }
    }

    private void GoToRecording() {
      int recordingId = int.Parse(GetCommandParameter("id"));

      recording = recordingBook.GetRecording(recordingId);
    }

    private void MoveToRecording() {
      string position = GetCommandParameter("goto");
      Recording newRecording = null;
      switch (position) {
        case "First":
          newRecording = recordingBook.GetFirstRecording();
          break;
        case "Previous":
          newRecording = recordingBook.GetPreviousRecording(this.recording);
          break;
        case "Next":
          newRecording = recordingBook.GetNextRecording(this.recording);
          break;
        case "Last":
          newRecording = recordingBook.GetLastRecording();
          break;
        default:
          if (EmpiriaString.IsInteger(position)) {
            newRecording = recordingBook.GetRecording(int.Parse(position));
          }
          break;
      }
      if (newRecording != null) {
        this.recording = newRecording;
      }
    }

    private void SetImageZoom() {
      decimal zoomFactor = decimal.Parse(cboZoomLevel.Value);

      currentImageWidth = Convert.ToInt32(Math.Round(1336m * zoomFactor, 0));
      currentImageHeight = Convert.ToInt32(Math.Round(994m * zoomFactor, 0));
    }

    protected string GetCurrentImagePath() {
      return recordingBook.ImagingFilesFolder.GetImageURL(currentImagePosition);
    }

    private void Initialize() {
      recordingBook = RecordingBook.Parse(int.Parse(Request.QueryString["bookId"]));
      if (String.IsNullOrEmpty(Request.QueryString["id"])) {
        recording = recordingBook.GetLastRecording();
        if (recording != null) {
          Response.Redirect("recording.book.analyzer.aspx?bookId=" + recordingBook.Id.ToString() + "&id=" + recording.Id.ToString(), true);
        } else {
          Response.Redirect("recording.book.analyzer.aspx?bookId=" + recordingBook.Id.ToString() + "&id=-1", true);
        }
      } else if (int.Parse(Request.QueryString["id"]) == -1 || int.Parse(Request.QueryString["id"]) == 0) {
        recording = new Recording();
        recording.RecordingBook = this.recordingBook;
      } else {
        recording = Recording.Parse(int.Parse(Request.QueryString["Id"]));
      }
      if (!String.IsNullOrEmpty(Request.QueryString["image"])) {
        currentImagePosition = int.Parse(Request.QueryString["image"]);
      } else if (!IsPostBack && !recording.IsNew) {
        currentImagePosition = recording.StartImageIndex - 1;
      }
      if (IsPostBack && !String.IsNullOrEmpty(hdnCurrentImagePosition.Value)) {
        currentImagePosition = int.Parse(hdnCurrentImagePosition.Value);
      }
      if (!IsPostBack) {
        cboZoomLevel.Value = "1.00";
      }
      SetImageZoom();
      oRecordingDocumentEditor.Recording = this.recording;
      Recording annotation = new Recording();
      annotation.RecordingBook = this.recordingBook;
      oAnnotationDocumentEditor.Recording = annotation;

      if (RecordingPayment.UseInBatchRegistering) {
        oRecordingPaymentEditorControl.Recording = this.recording;
        oAnnotationPaymentEditorControl.Recording = annotation;
      } else {
        oRecordingPaymentEditorControl.Visible = false;
        oAnnotationPaymentEditorControl.Visible = false;
      }
    }

    private void LoadRecorderOfficersCombo() {
      LRSHtmlSelectControls.LoadRecorderOfficersCombo(this.cboAuthorizedBy, ComboControlUseMode.ObjectCreation,
                                                      recordingBook, null);
    }

    private void LoadRecordingActTypeCategoriesCombo() {
      LRSHtmlSelectControls.LoadRecordingActTypesCategoriesCombo(this.cboRecordingActTypeCategory, this.recordingBook);
    }

    private void LoadAnnotationActsCategoriesCombo() {
      LRSHtmlSelectControls.LoadAnnotationActTypesCategoriesCombo(this.cboAnnotationCategory, this.recordingBook);
    }

    protected string GetCurrentImageHeight() {
      return currentImageHeight.ToString() + "em";
    }

    protected string GetCurrentImageWidth() {
      return currentImageWidth.ToString() + "em";
    }

    protected string GetRecordingsViewerGrid() {
      return LRSGridControls.GetRecordingsSummaryTable(this.recordingBook.Recordings, this.recordingsPerViewerPage, 0);
    }

    protected int RecordingViewerPages() {
      return Convert.ToInt32((Math.Ceiling((double) this.recordingBook.Recordings.Count / (double) this.recordingsPerViewerPage)));
    }

    private void LoadRecordingViewerPagesCombo() {
      cboRecordingViewerPage.Items.Clear();
      int pages = RecordingViewerPages();
      for (int i = 0; i < pages; i++) {
        cboRecordingViewerPage.Items.Add(new ListItem((i + 1).ToString(), i.ToString()));
      }
    }

    #endregion Private methods

  } // class RecordingBookAnalyzer

} // namespace Empiria.Web.UI.LRS