/* Empiria® Web Application 2012 *****************************************************************************
*																																																						 *
*	 Solution  : Empiria® Web Application                         System   : Workflow Services Web Pages       *
*	 Namespace : Empiria.Web.UI.Workflow                          Assembly : Empiria.Web.UI.dll                *
*	 Type      : TasksDashboard                                   Pattern  : Explorer Web Page                 *
*	 Date      : 23/Oct/2012                                      Version  : 5.0      Pattern version: 2.0     *
*																																																						 *
*  Summary   : Multiview dashboard used for workflow task management.                                        *
*																																																						 *
******************************************************** Copyright © La Vía Óntica, SC. México, 1994-2012. **/
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Empiria.Government.LandRegistration;
using Empiria.Government.LandRegistration.Data;
using Empiria.Government.LandRegistration.UI;
using Empiria.Presentation;
using Empiria.Presentation.Web;

namespace Empiria.Web.UI.LRSAnalytics {

  public partial class DailyHistoricRecordingDashboard : MultiViewDashboard {

    #region Fields

    private RecorderOffice selectedRecorderOffice = RecorderOffice.Empty;

    #endregion Fields

    #region Protected methods

    protected void Page_Init(object sender, EventArgs e) {
      selectedRecorderOffice = LRSHtmlSelectControls.ParseRecorderOffice(this, cboRecorderOffice.UniqueID);
    }

    public sealed override Repeater ItemsRepeater {
      get { return this.itemsRepeater; }
    }

    protected sealed override bool ExecutePageCommand() {
      switch (base.CommandName) {
        case "updateUserInterface":
          base.UserViewSortExpression = string.Empty;
          LoadPageControls();
          base.LoadRepeater();
          return true;
        default:
          return false;
      }
    }

    protected sealed override void Initialize() {

    }

    protected sealed override DataView LoadDataSource() {
      if ((base.SelectedTabStrip == 0) && (cboView.Value == "DayByDayProgressAnalysis")) {
        if (User.CanExecute("BatchCapture.Supervisor")) {
          return AnalyticsData.RecorderOfficesStats();
        }
        //} else if ((base.SelectedTabStrip == 0) && (cboView.Value == "DayByDayProgressAnalysis")) {
        //return RecordingBooksData.GetVolumeRecordingBooks(RecordingBookStatus.Assigned, String.Empty, "RecordingBookFullName");
      } else if ((base.SelectedTabStrip == 0) && (cboView.Value == "ProductivityByAnalyst")) {
        if (User.CanExecute("BatchCapture.Supervisor")) {
          return AnalyticsData.PerformanceByAnalyst(selectedRecorderOffice, EmpiriaString.ToDate(txtFromDate.Value),
                                                    EmpiriaString.ToDateTimeMax(txtToDate.Value));
        }
      } else if ((base.SelectedTabStrip == 0) && (cboView.Value == "RecordingActTypeAnalysis")) {
        return AnalyticsData.RecordingActTypeIncidence(selectedRecorderOffice, EmpiriaString.ToDate(txtFromDate.Value),
                                                       EmpiriaString.ToDateTimeMax(txtToDate.Value));
      }
      return new DataView();
    }

    protected sealed override void LoadPageControls() {
      if (txtFromDate.Value == String.Empty) {
        txtFromDate.Value = DateTime.Today.AddDays(-7).ToString("dd/MMM/yyyy");
      }
      if (txtToDate.Value == String.Empty) {
        txtToDate.Value = DateTime.Today.ToString("dd/MMM/yyyy");
      }
      LRSHtmlSelectControls.LoadRecorderOfficeCombo(this.cboRecorderOffice, ComboControlUseMode.ObjectSearch, selectedRecorderOffice);
    }

    protected sealed override void SetRepeaterTemplates() {
      if ((base.SelectedTabStrip == 0) && (cboView.Value == "DayByDayProgressAnalysis")) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/analytics/recorder.offices.progress.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/analytics/recorder.offices.progress.items.ascx");
        itemsRepeater.FooterTemplate = Page.LoadTemplate("~/templates/analytics/recorder.offices.progress.footer.ascx");
        base.SetTotalsColumns("DomainTotalBooks", "DomainCreatedBooks", "DomainNotCreatedBooks",
                              "DomainFilesCount", "NoLegibleToReplaceImages", "NoLegibleToReplaceImagesPry",
                              "DomainRecordingsControlCount", "CapturedRecordingsCount",
                              "LeftCapturedRecordingsCount", "NoLegibleRecordingsCount", "NoLegibleRecordingsPry",
                              "ObsoleteRecordingsCount", "ObsoleteRecordingsPry");
        base.PageSize = 50;
        base.ViewColumnsCount = 7;
      } else if ((base.SelectedTabStrip == 0) && (cboView.Value == "ProductivityByRecorderOffice")) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/empty.header.ascx");
        base.PageSize = 50;
        base.ViewColumnsCount = 3;
      } else if ((base.SelectedTabStrip == 0) && (cboView.Value == "ProductivityByAnalyst")) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/analytics/performance.by.analyst.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/analytics/performance.by.analyst.items.ascx");
        itemsRepeater.FooterTemplate = Page.LoadTemplate("~/templates/analytics/performance.by.analyst.footer.ascx");
        base.SetTotalsColumns("TotalRecordingsCount", "NoLegibleRecordingsCount", "IncompleteRecordingsCount", "RegisteredRecordingsCount", "ClosedRecordingsCount",
                              "ObsoleteRecordingsCount", "PendingRecordingsCount", "ActiveRecordingsCount", "RecordingActsCount", "PropertiesCount");
        base.PageSize = 50;
        base.ViewColumnsCount = 12;
      } else if ((base.SelectedTabStrip == 0) && (cboView.Value == "RecordingActTypeAnalysis")) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/analytics/recording.act.type.analysis.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/analytics/recording.act.type.analysis.items.ascx");
        itemsRepeater.FooterTemplate = Page.LoadTemplate("~/templates/analytics/recording.act.type.analysis.footer.ascx");
        base.SetTotalsColumns("RecordingActsCount");
        base.SetParetoAnalysisColumn("RecordingActsCount");
        base.PageSize = 100;
        base.ViewColumnsCount = 6;
      } else if ((base.SelectedTabStrip == 2)) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/analytics/performance.by.recorder.office.header.ascx");
      } else {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/empty.header.ascx");
      }
    }

    #endregion Protected methods

    #region Private methods

    #endregion Private methods

  } // class DailyHistoricRecordingDashboard

} // namespace Empiria.Web.UI.LRSAnalytics