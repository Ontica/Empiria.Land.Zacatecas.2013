using System;

using Empiria.DataTypes;
using Empiria.Government.LandRegistration;

namespace Empiria.Web.UI.LRS {

  public partial class RecordingPaymentEditorControl : System.Web.UI.UserControl {

    #region Fields

    private Recording recording = Recording.Empty;

    #endregion Fields

    protected void Page_Load(object sender, EventArgs e) {

    }

    public Recording Recording {
      get { return recording; }
      set { recording = value; }
    }

    public void SetPaymentAmount(decimal amount) {
      txtRecordingPayment.Value = amount.ToString("N2");
      //txtRecordingPayment.Disabled = true;
      cboRecordingPaymentCurrency.Value = Currency.Default.Id.ToString();
    }

    public void LoadRecordingMainPayment() {
      if (!this.Visible) {
        return;
      }
      if (recording.RecordingPaymentList.Count == 0) {
        cboRecordingPaymentCurrency.Value = String.Empty;
        return;
      }
      RecordingPayment payment = recording.RecordingPaymentList[0];

      txtRecordingPaymentReceipt.Value = payment.ReceiptNumber;
      txtRecordingPaymentAdditionalReceipts.Value = payment.OtherReceipts;

      if (payment.FeeAmount.Currency.Equals(Currency.Unknown)) {
        cboRecordingPaymentCurrency.Value = "NC";
        txtRecordingPayment.Value = String.Empty;
      } else if (payment.FeeAmount.Currency.Equals(Currency.Empty)) {
        cboRecordingPaymentCurrency.Value = "ND";
        txtRecordingPayment.Value = String.Empty;
      } else if (payment.FeeAmount.Currency.Equals(Currency.NoLegible)) {
        cboRecordingPaymentCurrency.Value = "NL";
        txtRecordingPayment.Value = String.Empty;
      } else {
        cboRecordingPaymentCurrency.Value = payment.FeeAmount.Currency.Id.ToString();
        txtRecordingPayment.Value = payment.FeeAmount.Amount.ToString("N2");
      }
    }

    public void SaveRecordingMainPayment() {
      if (!this.Visible) {
        return;
      }
      RecordingPayment payment = null;

      if (recording.RecordingPaymentList.Count == 0) {
        payment = new RecordingPayment(this.recording);
      } else {
        payment = recording.RecordingPaymentList[0];
      }
      if (txtRecordingPayment.Value.Length == 0) {
        txtRecordingPayment.Value = "0.00";
      }
      payment.PaymentOffice = recording.RecordingBook.RecorderOffice;
      payment.PaymentTime = recording.AuthorizedTime;
      Currency currency = null;
      switch (cboRecordingPaymentCurrency.Value) {
        case "NC":
          currency = Currency.Unknown;
          break;
        case "NL":
          currency = Currency.NoLegible;
          break;
        case "ND":
          currency = Currency.Empty;
          break;
        default:
          currency = Currency.Parse(int.Parse(cboRecordingPaymentCurrency.Value));
          break; ;
      }
      payment.FeeAmount = Money.Parse(currency, decimal.Parse(txtRecordingPayment.Value));
      payment.ReceiptNumber = txtRecordingPaymentReceipt.Value;
      payment.OtherReceipts = txtRecordingPaymentAdditionalReceipts.Value;

      if (recording.RecordingPaymentList.Count == 0) {
        recording.AppendRecordingPayment(payment);
      } else {
        payment.Save();
      }
    }

  } // class RecordingDocumentEditorControl

} // namespace Empiria.Web.UI.LRS