/* Empiria® Web Application 2012 *****************************************************************************
*																																																						 *
*	 Solution  : Empiria® Web Application                         System   : Workplace Web Pages               *
*	 Namespace : Empiria.Web.UI.Ajax                              Assembly : Empiria.Web.UI.dll                *
*	 Type      : ControlBuilder                                   Pattern  : Ajax Services Web Page            *
*	 Date      : 23/Oct/2012                                      Version  : 5.0      Pattern version: 2.0     *
*																																																						 *
*  Summary   : Gets Empiria control contents through Ajax invocation.                                        *
*																																																						 *
******************************************************** Copyright © La Vía Óntica, SC. México, 1994-2012. **/

using Empiria.Presentation.Web;

namespace Empiria.Web.UI.Ajax {

  public partial class WorkplaceData : AjaxWebPage {

    protected override string ImplementsCommandRequest(string commandName) {
      switch (commandName) {
        case "doDumpPerformanceAnalysisCmd":
          DumpPerformanceAnalysisCommandHandler();
          return "true";
        case "resetSystemCacheCmd":
          ResetSystemCacheHandler();
          return "true";
        case "windowFeaturesCmd":
          return WindowFeaturesCommandHandler();
        default:
          throw new WebPresentationException(WebPresentationException.Msg.UnrecognizedCommandName,
                                             commandName);
      }
    }

    #region Private command handlers

    private void DumpPerformanceAnalysisCommandHandler() {
      Empiria.Data.DataOperation.DumpPerformanceTable();
      Ontology.MetaModelType.DumpCache();
    }

    private void ResetSystemCacheHandler() {
      //ObjectType.ResetCache();
      //ObjectTypeInfo.ResetCache();
    }

    private string WindowFeaturesCommandHandler() {
      string options = "status=yes,scrollbars=yes,fullscreen=no,location=no,menubar=no,resizable=yes";
      options += ",height=" + "520" + "px,width=" + "720" + "px";

      return options;
    }

    #endregion Private command handlers

    public WebPage GetPage() {
      return base.Session["AjaxWebPage"] as WebPage;
    }

  } // class WorkplaceData

} // namespace Empiria.Web.UI.Ajax