/* Empiria® Web Application 2012 *****************************************************************************
*																																																						 *
*	 Solution  : Empiria® Web Application                         System   : Workplace Web Pages               *
*	 Namespace : Empiria.Web.UI.HRM                               Assembly : Empiria.Web.UI.dll                *
*	 Type      : HRMControlPortal                                 Pattern  : Explorer Web Page                 *
*	 Date      : 23/Oct/2012                                      Version  : 5.0      Pattern version: 2.0     *
*																																																						 *
*  Summary   : Employee information editor page.                                                             *
*																																																						 *
******************************************************** Copyright © La Vía Óntica, SC. México, 1994-2012. **/
using System;
using Empiria.Contacts;
using Empiria.DataTypes;
using Empiria.Government.LandRegistration.Transactions;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

namespace Empiria.Government.LandRegistration.UI {

  public partial class LRSTransactionEditor : WebPage {

    #region Fields

    protected LRSTransaction transaction = null;
    private string onloadScript = String.Empty;

    #endregion Fields

    #region Public properties

    #endregion Public properties

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (!IsPostBack) {
        LoadEditor();
      } else {
        ExecuteCommand();
      }
    }

    private void Initialize() {
      int id = int.Parse(Request.QueryString["id"]);
      if (!String.IsNullOrWhiteSpace(Request["isNew"])) {
        onloadScript = "alert('El trámite fue creado correctamente.');";
      }
      if (id != 0) {
        transaction = LRSTransaction.Parse(id);
      } else {
        LRSTransactionType transactionType = LRSTransactionType.Parse(int.Parse(Request.QueryString["typeId"]));
        transaction = new LRSTransaction(transactionType);
        transaction.RecorderOffice = RecorderOffice.Parse(101);		/// Goto default RecordingOffice
      }
    }

    protected bool ShowConceptEditor() {
      if (this.transaction.IsNew) {
        return false;
      }
      if (this.CanReceiveTransaction()) {
        return false;
      }

      if (DateTime.Now.Subtract(new TimeSpan(0, 5, 0)) <= this.transaction.PostingTime) {
        return true;
      }
      return false;
    }

    private void ExecuteCommand() {
      switch (base.CommandName) {
        case "redirectThis":
          RedirectEditor();
          return;
        case "saveTransaction":
          SaveTransaction();
          RedirectEditor();
          return;
        case "reentryTransaction":
          ReentryTransaction();
          return;
        case "copyTransaction":
          CopyTransaction();
          return;
        case "goToTransaction":
          GoToTransaction();
          return;
        case "saveAndReceiveTransaction":
          SaveAndReceiveTransaction();
          LoadEditor();
          return;
        case "cancelTransaction":
          RedirectEditor();
          return;
        case "appendConcept":
          AppendConcept();
          RedirectEditor();
          return;
        case "deleteRecordingAct":
          DeleteRecordingAct();
          RedirectEditor();
          return;
        case "applyReceipt":
          ApplyReceipt();
          RedirectEditor();
          return;
        case "printTransaction":
          PrintTransaction();
          LoadEditor();
          return;
        case "printPaymentOrder":
          PrintPaymentOrder();
          LoadEditor();
          return;
        default:
          throw new NotImplementedException(base.CommandName);
      }
    }

    protected string OnloadScript() {
      return onloadScript;
    }

    protected bool HasRecordingActs {
      get {
        return (transaction.RecordingActs.Count != 0);
      }
    }

    private void LoadEditor() {
      txtTransactionKey.Value = transaction.Key;
      cboRecorderOffice.Value = transaction.RecorderOffice.Id.ToString();

      txtReceiptNumber.Value = transaction.ReceiptNumber;

      if (transaction.ReceiptNumber.Length != 0) {
        txtReceiptTotal.Value = transaction.ReceiptTotal.ToString("N2");
      }

      ObjectList<LRSDocumentType> list = transaction.TransactionType.GetDocumentTypes();

      HtmlSelectContent.LoadCombo(cboDocumentType, list, "Id", "Name",
                                  "( Seleccionar )", String.Empty, String.Empty);

      HtmlSelectContent.LoadCombo(cboManagementAgency, LRSTransaction.GetManagementAgenciesList(),
                                  "Id", "FullName", String.Empty, "Particular", String.Empty);

      cboDocumentType.Value = transaction.DocumentType.Id.ToString();
      txtDocumentNumber.Value = transaction.DocumentNumber;
      txtRequestedBy.Value = transaction.RequestedBy;
      txtContactEMail.Value = transaction.ContactEMail;
      txtContactPhone.Value = transaction.ContactPhone;

      txtPresentationDate.Value = transaction.PresentationTime.ToString("dd/MMM/yyyy HH:mm");
      txtControlNumber.Value = transaction.ControlNumber;
      txtReceivedBy.Value = transaction.ReceivedBy.Alias;
      txtRequestNotes.Value = transaction.RequestNotes;
      cboManagementAgency.Value = transaction.ManagementAgency.Id.ToString();

      cboRecordingActType.SelectedIndex = 0;
      cboLawArticle.SelectedIndex = 0;

      txtOperationValue.Value = String.Empty;

      if (transaction.IsNew) {
        cmdSaveTransaction.Value = "Crear la solicitud";
      } else {
        cmdSaveTransaction.Value = "Guardar la solicitud";
        LoadRecordingActCombos();
      }
    }

    protected bool ShowConceptsGrid() {
      if (this.transaction.IsNew) {
        return false;
      }
      if (this.transaction.TransactionType.Id == 704) {
        return false;
      }
      return true;
    }

    protected bool CanReceiveTransaction() {
      if (transaction.Status != Empiria.Government.LandRegistration.Transactions.TransactionStatus.Payment) {
        return false;
      }
      if (transaction.TransactionType.Id == 704) {
        return true;
      }
      if (transaction.ReceiptNumber.Length != 0 && HasRecordingActs) {
        return true;
      }
      return false;
    }

    protected bool CanPrintPayment() {
      if (this.HasRecordingActs && transaction.Status == Empiria.Government.LandRegistration.Transactions.TransactionStatus.Payment) {
        return true;
      }
      return false;
    }

    protected bool CanPrintReceipt() {
      if (transaction.Status == Empiria.Government.LandRegistration.Transactions.TransactionStatus.Payment) {
        return false;
      }
      if (this.HasRecordingActs || transaction.TransactionType.Id == 704) {
        return true;
      }
      return false;
    }

    private void GoToTransaction() {
      Response.Redirect("transaction.editor.aspx?id=" + GetCommandParameter("id", true), true);
    }

    private void LoadRecordingActCombos() {
      RecordingActTypeCategory recordingActTypeCategory = RecordingActTypeCategory.Parse(int.Parse(cboRecordingActTypeCategory.Value));
      ObjectList<RecordingActType> list = recordingActTypeCategory.GetItems();

      HtmlSelectContent.LoadCombo(this.cboRecordingActType, list, "Id", "DisplayName",
                                  "( Seleccionar el acto jurídico )");
    }

    private void PrintTransaction() {
      this.SaveTransaction();
      if (transaction.Status == Empiria.Government.LandRegistration.Transactions.TransactionStatus.Payment) {
        //transaction.PrintTicket();
        onloadScript = "createNewWindow('payment.order.aspx?id=" + transaction.Id.ToString() + "')";
      } else {
        onloadScript = "createNewWindow('transaction.receipt.aspx?id=" + transaction.Id.ToString() + "')";
      }
    }

    private void PrintPaymentOrder() {
      this.SaveTransaction();
      onloadScript = "createNewWindow('payment.order.aspx?id=" + transaction.Id.ToString() + "')";
    }

    private decimal CalculatePayment() {
      //ObjectList<RecordingAct> list = transaction.Recording.RecordingActs;
      decimal total = 0m;
      //for (int i = 0; i < list.Count; i++) {
      //  RecordingAct recordingAct = list[i];
      //  decimal maxvalue = Math.Max(recordingAct.AppraisalAmount.Amount, recordingAct.OperationAmount.Amount);
      //  decimal subTotal = CalculatePayment(maxvalue);
      //  total += subTotal;
      //}
      return total;
    }

    private void SaveTransaction() {
      transaction.RecorderOffice = RecorderOffice.Parse(int.Parse(cboRecorderOffice.Value));
      transaction.DocumentNumber = txtDocumentNumber.Value;
      transaction.DocumentType = LRSDocumentType.Parse(int.Parse(cboDocumentType.Value));
      transaction.RequestedBy = EmpiriaString.TrimAll(txtRequestedBy.Value).ToUpperInvariant();
      transaction.RequestNotes = EmpiriaString.TrimAll(txtRequestNotes.Value);
      transaction.ManagementAgency = Contact.Parse(int.Parse(cboManagementAgency.Value));
      //transaction.ContactEMail = txtContactEMail.Value;
      //transaction.ContactPhone = txtContactPhone.Value;

      // Temporal
      if (transaction.TransactionType.Id == 704) {
        ApplyVoidReceipt();
      }

      bool isNew = transaction.IsNew;
      transaction.Save();

      onloadScript = "alert('Los cambios efectuados en la información del trámite se guardaron correctamente.');";

      if (!isNew) {
        return;
      }
      if (transaction.TransactionType.Id == 700) {
        switch (transaction.DocumentType.Id) {
          case 722:
            AppendConcept(2292, 848);
            ApplyVoidReceipt();
            return;
          case 725:
            AppendConcept(2108, 848);
            return;
          default:
            AppendConcept(2100, 850);
            return;
        }
      } else if (transaction.TransactionType.Id == 701) {
        switch (transaction.DocumentType.Id) {
          case 730:
            AppendConcept(2111, 873);
            return;
          case 731:
            AppendConcept(2110, 874);
            return;
          case 732:
            AppendConcept(2113, 871);
            return;
          case 733:
            AppendConcept(2112, 872);
            return;
        }
      } else if (transaction.TransactionType.Id == 704) {
        ApplyVoidReceipt();
      }
    }

    private void ApplyVoidReceipt() {
      transaction.ReceiptTotal = decimal.Zero;
      transaction.ReceiptNumber = "No aplica";
      transaction.Save();

      foreach (LRSTransactionAct act in transaction.RecordingActs) {
        act.ReceiptNumber = transaction.ReceiptNumber;
        act.Save();
      }
    }

    private void ApplyReceipt() {
      if (txtReceiptTotal.Value.Length != 0) {
        transaction.ReceiptTotal = decimal.Parse(txtReceiptTotal.Value);
      } else {
        transaction.ReceiptTotal = decimal.Zero;
      }
      transaction.ReceiptNumber = txtReceiptNumber.Value;
      transaction.Save();
      foreach (LRSTransactionAct act in transaction.RecordingActs) {
        act.ReceiptNumber = transaction.ReceiptNumber;
        act.Save();
      }
    }

    private void SaveAndReceiveTransaction() {
      SaveTransaction();
      string s = transaction.ValidateStatusChange(TransactionStatus.Received);

      transaction.Receive(String.Empty);

      onloadScript = "alert('Este trámite fue recibido satistactoriamente.');doOperation('redirectThis')";
    }

    private void ReentryTransaction() {
      SaveTransaction();
      transaction.DoReentry("Trámite reingresado");

      onloadScript = "alert('Este trámite fue reingresado correctamente.');doOperation('redirectThis')";
    }

    private void CopyTransaction() {
      SaveTransaction();
      LRSTransaction copy = new LRSTransaction(this.transaction.TransactionType);
      copy.RecorderOffice = this.transaction.RecorderOffice;
      copy.DocumentNumber = this.transaction.DocumentNumber;
      copy.DocumentType = this.transaction.DocumentType;
      copy.ManagementAgency = this.transaction.ManagementAgency;
      //copy.RequestedBy = this.transaction.RequestedBy;
      copy.RequestNotes = this.transaction.RequestNotes;

      bool isSpecialCase = (transaction.TransactionType.Id == 704 || (transaction.TransactionType.Id == 700 && transaction.DocumentType.Id == 722));

      if (isSpecialCase) {
        copy.ReceiptTotal = decimal.Zero;
        copy.ReceiptNumber = "No aplica";
      }
      copy.Save();

      foreach (LRSTransactionAct act in transaction.RecordingActs) {
        LRSTransactionAct newAct = new LRSTransactionAct(copy);

        newAct.RecordingActType = act.RecordingActType;
        newAct.LawArticle = act.LawArticle;
        newAct.OperationValue = act.OperationValue;
        newAct.Quantity = act.Quantity;
        newAct.Unit = act.Unit;
        newAct.Notes = act.Notes;
        if (isSpecialCase) {
          newAct.ReceiptNumber = copy.ReceiptNumber;
        }
        newAct.Save();
        //newAct.ReceiptNumber = transaction.ReceiptNumber;
      }
      onloadScript = @"alert('Este trámite fue copiado correctamente.\n\nEl nuevo trámite es el " + copy.Key +
                     @".\n\nAl cerrar esta ventana se mostrará el nuevo trámite.');";
      onloadScript += "doOperation('goToTransaction', " + copy.Id.ToString() + ");";
    }

    protected string GetRecordingActs() {
      ObjectList<LRSTransactionAct> list = transaction.RecordingActs;
      const string template = "<tr class='{CLASS}'><td>{COUNT}</td><td style='white-space:normal;width:30%;'>{CONCEPT}</td>" +
                              "<td style='white-space:nowrap;' align='right'>{OP.VALUE}</td><td align='right'>{QTY}</td><td>{UNIT}</td>" +
                              "<td style='white-space:normal;width:25%;'>{LAW.ARTICLES}</td>" +
                              "<td style='white-space:normal;width:30%;'>{NOTES}</td><td align='right'>{PAYMENT_ORDER}</td><td align='right'>{CONCEPT_TOTAL}</td>" +
                              "<td style='display:{SHOW_TOTALS}'><img src='../themes/default/buttons/trash.gif' alt='' onclick='return doOperation(\"deleteRecordingAct\", {ID})'</td></tr>";

      const string footer = "<tr class='totalsRow' style='display:{SHOW_TOTALS}'><td colspan='9'>&nbsp;&nbsp;<a href='javascript:doOperation(\"showConcept\")'>Agregar concepto</a>" +
                            "&nbsp; &nbsp; &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;  &nbsp;<a style='display:{SHOW_RECEIPT}' href='javascript:doOperation(\"showReceipt\")'>Aplicar recibo</a>" +
                            "</td></tr>";
      decimal total = 0;
      string html = String.Empty;
      for (int i = 0; i < list.Count; i++) {
        string temp = template.Replace("{COUNT}", (i + 1).ToString());
        temp = temp.Replace("{CLASS}", ((i % 2) == 0) ? "detailsItem" : "detailsOddItem");
        temp = temp.Replace("{CONCEPT}", list[i].RecordingActType.DisplayName);

        temp = temp.Replace("{OP.VALUE}", list[i].OperationValue.Amount != decimal.Zero ? list[i].OperationValue.ToString() : String.Empty);
        if (!list[i].Unit.IsEmptyInstance) {
          temp = temp.Replace("{QTY}", list[i].Quantity.ToString());
          temp = temp.Replace("{UNIT}", list[i].Unit.Name);
        } else {
          temp = temp.Replace("{QTY}", String.Empty);
          temp = temp.Replace("{UNIT}", String.Empty);
        }
        temp = temp.Replace("{NOTES}", list[i].Notes);
        temp = temp.Replace("{PAYMENT_ORDER}", list[i].ReceiptNumber);

        temp = temp.Replace("{LAW.ARTICLES}", list[i].LawArticle.Name);
        temp = temp.Replace("{RECEIPT}", list[i].ReceiptNumber);
        temp = temp.Replace("{CONCEPT_TOTAL}", list[i].Fee.Total != decimal.Zero ? list[i].Fee.Total.ToString("C2") : String.Empty);

        temp = temp.Replace("{REC.RIGHTS}", list[i].Fee.RecordingRights.ToString("N2"));
        temp = temp.Replace("{SHEETS}", list[i].Fee.SheetsRevision != 0 ? list[i].Fee.SheetsRevision.ToString("N2") : String.Empty);
        temp = temp.Replace("{ACLARATION}", list[i].Fee.Aclaration != 0 ? list[i].Fee.Aclaration.ToString("N2") : String.Empty);
        temp = temp.Replace("{USUFRUCT}", list[i].Fee.Usufruct != 0 ? list[i].Fee.Usufruct.ToString("N2") : String.Empty);
        temp = temp.Replace("{SERVIDUMBRE}", list[i].Fee.Easement != 0 ? list[i].Fee.Easement.ToString("N2") : String.Empty);
        temp = temp.Replace("{SIGN.CERT}", list[i].Fee.SignCertification != 0 ? list[i].Fee.SignCertification.ToString("N2") : String.Empty);
        temp = temp.Replace("{FOREIGN}", list[i].Fee.ForeignRecord != 0 ? list[i].Fee.ForeignRecord.ToString("N2") : String.Empty);
        temp = temp.Replace("{SUBTOTAL}", list[i].Fee.SubTotal.ToString("N2"));
        temp = temp.Replace("{DISCOUNT}", list[i].Fee.Discount.ToString("N2"));
        temp = temp.Replace("{TOTAL}", list[i].Fee.Total.ToString("C2"));
        temp = temp.Replace("{ID}", list[i].Id.ToString());
        html += temp;
        total += list[i].Fee.Total;
      }
      html = html + footer.Replace("{TOTAL}", total.ToString("C2"));
      html = html.Replace("{SHOW_TOTALS}", transaction.Status == TransactionStatus.Payment ? "inline" : "none");
      html = html.Replace("{SHOW_RECEIPT}", list.Count != 0 ? "inline" : "none");
      return html;
    }

    protected string GetTransactionTrack() {
      const string template = "<tr class='{CLASS}' valign='top'><td>{CURRENT.STATUS}</td>" +
                                 "<td style='white-space:nowrap;'>{RESPONSIBLE}</td><td align='right'>{CHECK.IN}</td><td align='right'>{END.PROCESS}</td><td align='right'>{CHECK.OUT}</td>" +
                                 "<td align='right'>{ELAPSED.TIME}</td><td>{STATUS}</td><td style='white-space:normal;width:30%;'>{NOTES}</td></tr>";

      const string subTotalTemplate = "<tr class='detailsGreenItem'><td colspan='5'>&nbsp;</td><td  align='right'><b>{WORK.TOTAL.TIME}</b></td><td>&nbsp;</td><td>Duración total: <b>{TOTAL.TIME}</b></td></tr>";

      const string footer = "<tr class='detailsSuperHeader' valign='middle'><td colspan='5' style='height:28px'>&nbsp;&nbsp;{NEXT.STATUS}</td><td  align='right'><b>{WORK.TOTAL.TIME}</b></td><td>&nbsp;</td><td>&nbsp;&nbsp;&nbsp;Duración total: <b>{TOTAL.TIME}</b></td></tr>";

      ObjectList<LRSTransactionTrack> track = this.transaction.Track;

      string html = String.Empty;
      double subTotalWorkTimeSeconds = 0.0d;
      double subTotalElapsedTimeSeconds = 0.0d;
      double workTimeSeconds = 0.0d;
      double elapsedTimeSeconds = 0.0d;

      LRSTransactionTrack o = null;
      bool hasReentries = false;
      for (int i = 0; i < track.Count; i++) {
        string temp = String.Empty;
        o = track[i];
        if (o.CurrentStatus == TransactionStatus.Reentry) {
          temp = subTotalTemplate.Replace("{WORK.TOTAL.TIME}", EmpiriaString.TimeSpanString(subTotalWorkTimeSeconds));
          temp = temp.Replace("{TOTAL.TIME}", EmpiriaString.TimeSpanString(subTotalElapsedTimeSeconds));
          subTotalWorkTimeSeconds = 0.0d;
          subTotalElapsedTimeSeconds = 0.0d;
          hasReentries = true;
          html += temp;
        }

        temp = template.Replace("{CURRENT.STATUS}", o.CurrentStatus == TransactionStatus.Reentry ? "<b>" + o.CurrentStatusName + "</b>" : o.CurrentStatusName);

        temp = temp.Replace("{CLASS}", ((i % 2) == 0) ? "detailsItem" : "detailsOddItem");
        temp = temp.Replace("{RESPONSIBLE}", o.Responsible.Alias);

        string dateFormat = "dd/MMM/yyyy HH:mm";
        if (o.CheckInTime.Year == DateTime.Today.Year) {
          dateFormat = "dd/MMM HH:mm";
        }
        temp = temp.Replace("{CHECK.IN}", o.CheckInTime.ToString(dateFormat));
        temp = temp.Replace("{END.PROCESS}", o.EndProcessTime != ExecutionServer.DateMaxValue ? o.EndProcessTime.ToString(dateFormat) : "&nbsp;");
        temp = temp.Replace("{CHECK.OUT}", o.CheckOutTime != ExecutionServer.DateMaxValue ? o.CheckOutTime.ToString(dateFormat) : "&nbsp;");

        TimeSpan elapsedTime = o.OfficeWorkElapsedTime;
        temp = temp.Replace("{ELAPSED.TIME}", elapsedTime == TimeSpan.Zero ? "&nbsp;" : EmpiriaString.TimeSpanString(elapsedTime));
        temp = temp.Replace("{STATUS}", o.StatusName);

        temp = temp.Replace("{NOTES}", o.Notes);
        html += temp;

        subTotalWorkTimeSeconds += elapsedTime.TotalSeconds;
        subTotalElapsedTimeSeconds += o.ElapsedTime.TotalSeconds;
        workTimeSeconds += elapsedTime.TotalSeconds;
        elapsedTimeSeconds += o.ElapsedTime.TotalSeconds;
      }
      if (hasReentries) {
        string temp = subTotalTemplate.Replace("{WORK.TOTAL.TIME}", EmpiriaString.TimeSpanString(subTotalWorkTimeSeconds));
        temp = temp.Replace("{TOTAL.TIME}", EmpiriaString.TimeSpanString(subTotalElapsedTimeSeconds));
        html += temp;
      }
      html += footer.Replace("{WORK.TOTAL.TIME}", EmpiriaString.TimeSpanString(workTimeSeconds));
      html = html.Replace("{TOTAL.TIME}", EmpiriaString.TimeSpanString(elapsedTimeSeconds));
      html = html.Replace("{NEXT.STATUS}", (o != null && o.Status == TrackStatus.OnDelivery) ? "Próximo estado: &nbsp;<b>" + o.NextStatusName + "</b>" : String.Empty);

      return html;
    }

    private void AppendConcept(int conceptTypeId, int lawArticleId) {
      LRSTransactionAct act = new LRSTransactionAct(this.transaction);
      act.RecordingActType = RecordingActType.Parse(conceptTypeId);
      act.LawArticle = LRSLawArticle.Parse(lawArticleId);
      act.Save();
    }

    private void AppendConcept() {
      LRSTransactionAct act = new LRSTransactionAct(this.transaction);

      act.RecordingActType = RecordingActType.Parse(int.Parse(Request.Form[cboRecordingActType.ClientID]));
      act.LawArticle = LRSLawArticle.Parse(int.Parse(Request.Form[cboLawArticle.ClientID]));
      //act.ReceiptNumber = cboReceipts.Value.Length != 0 ? cboReceipts.Value : txtRecordingActReceipt.Value;

      if (txtOperationValue.Value.Length != 0) {
        act.OperationValue = Money.Parse(Currency.Parse(int.Parse(cboOperationValueCurrency.Value)),
                                         decimal.Parse(txtOperationValue.Value));
      }
      if (txtQuantity.Value.Length != 0) {
        act.Quantity = decimal.Parse(txtQuantity.Value);
      }
      act.Unit = Empiria.DataTypes.Unit.Parse(int.Parse(cboUnit.Value));
      act.Notes = EmpiriaString.TrimAll(txtConceptNotes.Value);
      act.Save();

      txtOperationValue.Value = String.Empty;
      txtQuantity.Value = String.Empty;
      cboUnit.Value = "-1";
      txtConceptNotes.Value = String.Empty;

      onloadScript += "alert('El concepto se agregó correctamente.');";
    }


    private void DeleteRecordingAct() {
      LRSTransactionAct act = LRSTransactionAct.Parse(int.Parse(GetCommandParameter("id")));

      act.Delete();
      onloadScript += "alert('Se eliminó correctamente el acto jurídico/concepto de la lista.');";
    }

    protected string GetTitle() {
      if (this.transaction.IsNew) {
        return this.transaction.Key + ": " + this.transaction.TransactionType.Name;
      } else {
        return this.transaction.TransactionType.Name + ": " + this.transaction.Key;
      }
    }

    private void RedirectEditor() {
      var isNew = (int.Parse(Request.QueryString["id"]) == 0);
      if (isNew) {
        Response.Redirect("transaction.editor.aspx?id=" + transaction.Id.ToString() + "&isNew=true");
        //} else {
        //  Response.Redirect("transaction.editor.aspx?id=" + transaction.Id.ToString());
      } else {
        Response.Redirect("transaction.editor.aspx?id=" + transaction.Id.ToString());
      }
    }

  } // class ObjectEditor

} // namespace Empiria.Web.UI.Editors