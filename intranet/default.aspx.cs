/* Empiria® Web Application 2012 *****************************************************************************
*																																																						 *
*	 Solution  : Empiria® Web Application                         System   : Workplace Web Pages               *
*	 Namespace : Empiria.Web.UI                                   Assembly : Empiria.Web.UI.dll                *
*	 Type      : LogonPage										                    Pattern  : Logon Web Page                    *
*	 Date      : 23/Oct/2012                                      Version  : 5.0      Pattern version: 1.0     *
*																																																						 *
*  Summary   : Gets user credentials and redirects users to the workplace start page.                        *
*																																																						 *
******************************************************** Copyright © La Vía Óntica, SC. México, 1994-2012. **/
using System;

using Empiria.Presentation.Web.Controllers;
using Empiria.Security;


namespace Empiria.Web.UI {

  public partial class LogonPage : System.Web.UI.Page {

    #region Fields

    private FormsLogonController controller = new FormsLogonController();
    protected string clientScript = String.Empty;

    protected string x;

    #endregion Fields

    #region Public properties

    public FormsLogonController Controller {
      get { return controller; }
    }

    #endregion Public properties

    #region Event handlers

    protected void Page_Load(object sender, System.EventArgs e) {
      if (!IsPostBack) {
        SetDefaultValues();
      } else {
        if (String.IsNullOrEmpty(txtUserId.Value)) {
          clientScript = "alert('Para efectuar esta operación requiero el identificador de usuario.');";
          return;
        }
        if (String.IsNullOrEmpty(txtPassword.Value)) {
          clientScript = "alert('Para efectuar esta operación requiero la contraseña de acceso al sistema.');";
          return;
        }
        if (!TryLogon(txtUserId.Value, txtPassword.Value)) {
          SetDefaultValues();
          txtPassword.Value = String.Empty;
        }
      }
    }

    #endregion Event handlers

    #region Private methods

    private bool TryLogon(string userName, string password) {
      userName = userName.Trim();
      password = password.Trim();

      userName = Cryptographer.Encrypt(EncryptionMode.EntropyKey, userName, Session.SessionID);
      password = Cryptographer.Encrypt(EncryptionMode.EntropyKey, password, Session.SessionID);

      return this.Controller.Logon(userName, password, 1);
    }

    private void SetDefaultValues() {
      string lastUserName = this.Controller.GetLastAuthenticatedUserName();

      if (!IsPostBack) {
        txtUserId.Value = lastUserName;
      }
      txtAccessCode.Value = "ABCDEFG";
    }

    protected string GetDevelopmentCode() {
      if (Request.Url.ToString().StartsWith("http://jmcota/zacatecas/")) {
        return "getElement('txtPassword').value = 's3cur1ty'";
      } else {
        return String.Empty;
      }
    }

    protected string PROOF() {
      //return BaseObject.CacheCount.ToString("N0");
      return String.Empty;
    }

    #endregion Private methods

  } // class LogonPage

} // namespace Empiria.Web.UI