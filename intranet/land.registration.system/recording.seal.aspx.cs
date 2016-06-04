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



using Empiria.Government.LandRegistration;
using Empiria.Government.LandRegistration.Transactions;

namespace Empiria.Web.UI.FSM {

  public partial class RecordingSeal : System.Web.UI.Page {

    #region Fields

    protected LRSTransaction transaction = null;
    private ObjectList<Recording> recordings = null;
    private Recording baseRecording = null;

    #endregion Fields

    #region Constructors and parsers

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
    }

    #endregion Constructors and parsers

    #region Private methods

    private void Initialize() {
      transaction = LRSTransaction.Parse(int.Parse(Request.QueryString["transactionId"]));
      recordings = transaction.Document.GetRecordings(transaction);
      Assertion.Require(recordings.Count > 0, "Document does not have recordings.");

      int recordingId = int.Parse(Request.QueryString["id"]);
      if (recordingId != -1) {
        baseRecording = recordings.Find((x) => x.Id == recordingId);
      } else {
        recordings.Sort((x, y) => x.CapturedTime.CompareTo(y.CapturedTime));
        baseRecording = recordings[recordings.Count - 1];
      }
      Assertion.EnsureObject(baseRecording, "We have a problem reading document recording data.");
    }

    protected string CustomerOfficeName() {
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        return "Direcci�n de Notar�as y Registros P�blicos";
      } else {
        return "Direcci�n de Catastro y Registro P�blico";
      }
    }

    protected string DistrictName {
      get {
        if (ExecutionServer.LicenseName == "Zacatecas") {
          return "Registro P�blico del Distrito de Zacatecas";
        }
        return String.Empty;
      }
    }

    protected bool ShowAllRecordings {
      get {
        return (int.Parse(Request.QueryString["id"]) == -1);
      }
    }

    protected string GetPaymentText() {
      const string t = "Derechos por <b>{AMOUNT}</b> seg�n recibo <b>{RECEIPT}</b> expedido por la Secretar�a de Finanzas del Estado, que se archiva.";

      string x = t.Replace("{AMOUNT}", transaction.ReceiptTotal.ToString("C2"));
      x = x.Replace("{RECEIPT}", transaction.ReceiptNumber);

      return x;
    }

    protected string GetPrelationText() {
      const string t = "Presentado para su examen y registro en	{CITY}, el <b>{DATE} a las {TIME} horas</b>, bajo el n�mero de tr�mite <b>{NUMBER}</b> - Conste";


      DateTime presentationTime = transaction.LastReentryTime == ExecutionServer.DateMaxValue ? transaction.PresentationTime : transaction.LastReentryTime;

      string x = t.Replace("{DATE}", presentationTime.ToString(@"dd \de MMMM \de yyyy"));
      x = x.Replace("{TIME}", presentationTime.ToString("HH:mm:ss"));
      x = x.Replace("{NUMBER}", transaction.Key);
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        x = x.Replace("{CITY}", "Tlaxcala de Xicot�ncatl, Tlaxcala");
      } else {
        x = x.Replace("{CITY}", "Zacatecas, Zacatecas");
      }
      return x;
    }

    protected string GetRecordingsText() {
      if (this.ShowAllRecordings) {
        return GetAllRecordingsText();
      }

      const string tlaxcala = "Registrado bajo el n�mero de <b>partida {NUMBER}</b> del <b>{VOL}</b> Secci�n <b>{SECTION}</b> del <b>Distrito de {DISTRICT}</b>, con el n�mero de documento electr�nico: <b>{DOCUMENT}</b>";
      const string zacatecas = "Registrado bajo el n�mero de <b>inscripci�n {NUMBER}</b> del <b>{VOL}</b> <b>{SECTION}</b> del <b>Distrito Judicial de {DISTRICT}</b>.";
      string x = String.Empty;

      if (ExecutionServer.LicenseName == "Tlaxcala") {
        x = tlaxcala.Replace("{NUMBER}", baseRecording.Number);
      } else {
        x = zacatecas.Replace("{NUMBER}", baseRecording.Number);
      }
      x = x.Replace("{VOL}", baseRecording.RecordingBook.Name);
      x = x.Replace("{SECTION}", baseRecording.RecordingBook.RecordingsClass.Name);
      x = x.Replace("{DISTRICT}", baseRecording.RecordingBook.RecorderOffice.Alias);
      x = x.Replace("{DOCUMENT}", transaction.Document.DocumentKey);

      return x;
    }

    protected string GetRecordingOfficialsInitials() {
      string temp = String.Empty;

      for (int i = 0; i < recordings.Count; i++) {
        string initials = recordings[i].CapturedBy.Nickname;
        if (initials.Length == 0) {
          continue;
        }
        if (!temp.Contains(initials)) {
          temp += initials + " ";
        }
      }
      temp = temp.Trim().ToLowerInvariant();
      return temp.Length != 0 ? "* " + temp : String.Empty;
    }

    protected string GetAllRecordingsText() {
      const string docMultiTlax = "Registrado con el n�mero de documento electr�nico <b>{DOCUMENT}</b>, bajo las siguientes {COUNT} partidas registrales:<br/><br/>";
      const string docMultiZac = "Registrado bajo las siguientes {COUNT} inscripciones:<br/><br/>";

      const string docOneTlax = "Registrado con el n�mero de documento electr�nico <b>{DOCUMENT}</b>, bajo la siguiente partida registral:<br/><br/>";
      const string docOneZac = "Registrado bajo la siguiente inscripci�n:<br/><br/>";

      const string t1Tlax = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Partida <b>{NUMBER}</b> del <b>{VOL}</b> Secci�n <b>{SECTION}</b> del <b>Distrito de {DISTRICT}</b>.<br/>";
      const string t1Zac = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Inscripci�n <b>{NUMBER}</b> del <b>{VOL}</b> <b>{SECTION}</b> del <b>Distrito Judicial de {DISTRICT}</b>.<br/>";

      string html = String.Empty;


      string docMulti = ExecutionServer.LicenseName == "Tlaxcala" ? docMultiTlax : docMultiZac;
      string docOne = ExecutionServer.LicenseName == "Tlaxcala" ? docOneTlax : docOneZac;

      if (this.recordings.Count > 1) {
        html = docMulti.Replace("{DOCUMENT}", transaction.Document.DocumentKey);
        html = html.Replace("{COUNT}", this.recordings.Count.ToString() + " (" + EmpiriaString.SpeechInteger(this.recordings.Count).ToLower() + ")");
      } else if (this.recordings.Count == 1) {
        html = docOne.Replace("{DOCUMENT}", transaction.Document.DocumentKey);
      } else if (this.recordings.Count == 0) {
        throw new Exception("Document does not have recordings.");
      }

      for (int i = 0; i < recordings.Count; i++) {
        string x = (ExecutionServer.LicenseName == "Tlaxcala" ? t1Tlax : t1Zac).Replace("{NUMBER}", recordings[i].Number);
        x = x.Replace("{VOL}", recordings[i].RecordingBook.Name);
        x = x.Replace("{SECTION}", recordings[i].RecordingBook.RecordingsClass.Name);
        x = x.Replace("{DISTRICT}", recordings[i].RecordingBook.RecorderOffice.Alias);
        html += x;
      }
      return html;
    }

    protected string GetRecordingPlaceAndDate() {
      const string t = "Registrado en {CITY}, a las {TIME} horas del {DATE}. Doy Fe.";

      string x = t.Replace("{DATE}", baseRecording.CapturedTime.ToString(@"dd \de MMMM \de yyyy"));
      x = x.Replace("{TIME}", baseRecording.CapturedTime.ToString(@"HH:mm"));
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        x = x.Replace("{CITY}", "Tlaxcala de Xicot�ncatl, Tlaxcala");
      } else {
        x = x.Replace("{CITY}", "Zacatecas, Zacatecas");
      }
      return x;
    }

    protected string GetRecordingSignerPosition() {
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        return "Director de Notar�as y Registro P�blico de la Propiedad y del Comercio";
      } else {
        return "C. Oficial Registrador del Distrito Judicial de Zacatecas";
      }
    }

    protected string GetRecordingSignerName() {
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        return "Lic. Sergio Cuauht�moc Lima L�pez";
      } else {
        return "Lic. Teresa de Jes�s Alvarado Ortiz";
      }
    }

    protected string GetDigitalSeal() {
      string s = "||" + transaction.Key + "|" + transaction.Document.DocumentKey;
      if (this.ShowAllRecordings) {
        for (int i = 0; i < recordings.Count; i++) {
          s += "|" + recordings[i].Id.ToString();
        }
      } else {
        s += "|" + this.baseRecording.Id.ToString();
      }
      s += "||";
      return Empiria.Security.Cryptographer.CreateDigitalSign(s);
    }

    protected string GetDigitalSignature() {
      string s = "||" + transaction.Key + "|" + transaction.Document.DocumentKey;
      if (this.ShowAllRecordings) {
        for (int i = 0; i < recordings.Count; i++) {
          s += "|" + recordings[i].Id.ToString();
        }
      } else {
        s += "|" + this.baseRecording.Id.ToString();
      }
      return Empiria.Security.Cryptographer.CreateDigitalSign(s + "eSign");
    }

    protected string GetUpperMarginPoints() {
      decimal centimeters = Math.Max(transaction.Document.SealUpperPosition, 1.0m);
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        return (28.3464657m).ToString("G4");
      } else {
        return (centimeters * 28.3464657m).ToString("G4");
      }
    }

    protected string GetLeftMargin() {
      if (ExecutionServer.LicenseName == "Tlaxcala") {
        return "padding-left:2cm;";
      } else {
        return String.Empty;
      }
    }

    #endregion Private methods

  } // class RecordingSeal

} // namespace Empiria.Web.UI.FSM