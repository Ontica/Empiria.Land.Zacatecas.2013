/* Empiria® Web Application 2012 *****************************************************************************
*																																																						 *
*	 Solution  : Empiria® Web Application                         System   : Workplace Web Pages               *
*	 Namespace : Empiria.Web.UI.Ajax                              Assembly : Empiria.Web.UI.dll                *
*	 Type      : LandRegistrationSystemData                       Pattern  : Ajax Services Web Page            *
*	 Date      : 23/Oct/2012                                      Version  : 5.0      Pattern version: 2.0     *
*																																																						 *
*  Summary   : Gets Empiria control contents through Ajax invocation.                                        *
*																																																						 *
******************************************************** Copyright © La Vía Óntica, SC. México, 1994-2012. **/
using System;

using Empiria.Presentation.Web;

namespace Empiria.Web.UI.Ajax {

  public partial class GeneralSystemData : AjaxWebPage {

    protected override string ImplementsCommandRequest(string commandName) {
      switch (commandName) {
        case "isNoLabourDateCmd":
          return IsNoLabourDateCommandHandler();
        case "daysBetweenCmd":
          return DaysBetweenCommandHandler();
        default:
          throw new WebPresentationException(WebPresentationException.Msg.UnrecognizedCommandName,
                                             commandName);
      }
    }

    #region Private command handlers

    private string DaysBetweenCommandHandler() {
      DateTime fromDate = EmpiriaString.ToDate(GetCommandParameter("fromDate", false));
      DateTime toDate = EmpiriaString.ToDate(GetCommandParameter("toDate", false));

      return Empiria.DataTypes.Calendar.DaysBetween(fromDate, toDate).ToString();
    }

    private string IsNoLabourDateCommandHandler() {
      DateTime date = EmpiriaString.ToDate(GetCommandParameter("date", false));

      bool result = (Empiria.DataTypes.Calendar.IsWeekendDate(date) || Empiria.DataTypes.Calendar.IsNoLabourDate(date));

      return result.ToString();
    }

    #endregion Private command handlers

  } // class WorkplaceData

} // namespace Empiria.Web.UI.Ajax