/* Empiria® Web Application 2012 *****************************************************************************
*																																																						 *
*	 Solution  : Empiria® Web Application                         System   : Workplace Web Pages               *
*	 Namespace : Empiria.Web.UI.Workplace                         Assembly : Empiria.Web.UI.dll                *
*	 Type      : Dashboard                                        Pattern  : Dashboard Web Page                *
*	 Date      : 23/Oct/2012                                      Version  : 5.0      Pattern version: 2.0     *
*																																																						 *
*  Summary   : Web page that serves as a canvas for display DashboardItem type elements.                     *
*																																																						 *
******************************************************** Copyright © La Vía Óntica, SC. México, 1994-2012. **/
using System;

using Empiria.Presentation.Web;

namespace Empiria.Web.UI.Workplace {

  public partial class Dashboard : WebPage {

    #region Fields

    protected WebViewModel dashboardWebViewModel = null;

    #endregion Fields

    protected void Page_Load(object sender, EventArgs e) {
      Initialize();
      if (!IsPostBack) {
        //LoadDashboard();
      } else {
        ExecuteCommand();
      }
      //base.Master.SetEndLoadScript("showTabStrip(" + "0" + ");");			
    }

    private void Initialize() {
      if (!String.IsNullOrEmpty(Request.QueryString["dashboardId"])) {
        dashboardWebViewModel = WebViewModel.Parse(Convert.ToInt32(Request.QueryString["dashboardId"]));
      } else {
        dashboardWebViewModel = WebViewModel.Parse(101);
      }
      PrepareAjaxPage();
    }

    private void PrepareAjaxPage() {
      if (base.Session["AjaxWebPage"] == null) {
        base.Session.Add("AjaxWebPage", this);
      }
    }

    private void ExecuteCommand() {

    }

  } // class Dashboard

} // namespace Empiria.Web.UI.Workplace