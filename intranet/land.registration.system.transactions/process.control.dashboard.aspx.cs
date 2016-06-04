/* Empiria� Web Application 2012 *****************************************************************************
*																																																						 *
*	 Solution  : Empiria� Web Application                         System   : Workflow Services Web Pages       *
*	 Namespace : Empiria.Web.UI.Workflow                          Assembly : Empiria.Web.UI.dll                *
*	 Type      : TasksDashboard                                   Pattern  : Explorer Web Page                 *
*	 Date      : 23/Oct/2012                                      Version  : 5.0      Pattern version: 2.0     *
*																																																						 *
*  Summary   : Multiview dashboard used for workflow task management.                                        *
*																																																						 *
******************************************************** Copyright � La V�a �ntica, SC. M�xico, 1994-2012. **/
using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using Empiria.Contacts;
using Empiria.Government.LandRegistration.Data;
using Empiria.Government.LandRegistration.Transactions;
using Empiria.Presentation.Web;
using Empiria.Presentation.Web.Content;

namespace Empiria.Web.UI.LRS {

  public partial class ProcessControlDashboard : MultiViewDashboard {

    #region Protected methods

    private string selectedComboFromValue = String.Empty;

    protected void Page_Init(object sender, EventArgs e) {
      cboFrom.ViewStateMode = System.Web.UI.ViewStateMode.Enabled;
      cboFrom.EnableViewState = true;
      cboResponsible.ViewStateMode = System.Web.UI.ViewStateMode.Enabled;
      cboResponsible.EnableViewState = true;

      selectedComboFromValue = String.IsNullOrEmpty(Request.Form[cboFrom.UniqueID]) ? String.Empty : Request.Form[cboFrom.UniqueID];
    }

    public sealed override Repeater ItemsRepeater {
      get { return this.itemsRepeater; }
    }

    protected sealed override bool ExecutePageCommand() {
      switch (base.CommandName) {
        case "receiveLRSTransaction":
          ReceiveLRSTransaction();
          base.LoadRepeater();
          return true;
        case "takeLRSTransaction":
          TakeLRSTransaction();
          base.LoadRepeater();
          return true;
        case "changeTransactionStatus":
          ChangeTransactionStatus();
          base.LoadRepeater();
          return true;
        case "returnDocumentToMe":
          ReturnDocumentToMe();
          base.LoadRepeater();
          return true;
        case "updateUserInterface":
          base.LoadRepeater();
          return true;
        default:
          return false;
      }
    }

    protected sealed override void Initialize() {

    }

    protected sealed override DataView LoadDataSource() {
      Contact me = Contact.Parse(ExecutionServer.CurrentUserId);
      string filter = GetFilter();
      string sort = String.Empty;
      if (base.SelectedTabStrip == 0) {
        if (!User.CanExecute("LRSTransaction.ReceiveTransaction")) {
          if (filter.Length != 0) {
            filter += " AND ";
          }
          filter += "(TransactionStatus NOT IN ('D','L'))";
          return TransactionData.GetLRSResponsibleTransactionInbox(me, TrackStatus.Pending, filter, sort);
        } else {
          if (filter.Length != 0) {
            filter += " AND ";
          }
          filter += "((ResponsibleId = " + User.Id.ToString() + ") OR (TransactionStatus = 'Y')) AND (TrackStatus = 'P') AND (TransactionStatus NOT IN ('D','L'))";
          return TransactionData.GetLRSTransactions(filter, sort);
        }
      } else if (base.SelectedTabStrip == 1) {
        return TransactionData.GetLRSResponsibleTransactionInbox(me, TrackStatus.OnDelivery, filter, sort);
      } else if (base.SelectedTabStrip == 2) {
        // CORRECT THIS
        return TransactionData.GetLRSResponsibleTransactionInbox(me, TrackStatus.Closed, filter, sort);
      } else if (base.SelectedTabStrip == 3) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        filter += "NextTransactionStatus NOT IN ('R','C','Q','H')";
        if (!String.IsNullOrWhiteSpace(selectedComboFromValue)) {
          return TransactionData.GetLRSResponsibleTransactionInbox(Contact.Parse(int.Parse(selectedComboFromValue)), TrackStatus.OnDelivery, filter, sort);
        }
      } else if (base.SelectedTabStrip == 4) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        filter += "(TransactionStatus IN ('D','L'))";
        return TransactionData.GetLRSTransactions(filter, sort);
      } else if (base.SelectedTabStrip == 5) {
        // CORRECT THIS
        return TransactionData.GetLRSTransactions(filter, sort);
      } else if (base.SelectedTabStrip == 6) {
        return TransactionData.GetLRSTransactions(filter, sort);
      }
      return new DataView();
    }

    protected sealed override void LoadPageControls() {
      if (!IsPostBack) {
        LoadCombos();
      }
      if (txtFromDate.Value == String.Empty) {
        txtFromDate.Value = DateTime.Parse("01/Oct/2012").ToString("dd/MMM/yyyy");
      }
      if (txtToDate.Value == String.Empty) {
        txtToDate.Value = DateTime.Today.ToString("dd/MMM/yyyy");
      }
      cboFrom.Value = selectedComboFromValue;
      if (!IsPostBack) {
        cboStatus.SelectedIndex = 1;
      }
    }

    private void LoadCombos() {
      ObjectList<Contact> list = TransactionData.GetContactsWithOutboxDocuments();
      HtmlSelectContent.LoadCombo(this.cboFrom, list, "Id", "Alias",
                                  "( �Qui�n le est� entregando? )", String.Empty, String.Empty);
      DataView view = TransactionData.GetContactsWithActiveTransactions();

      HtmlSelectContent.LoadCombo(this.cboResponsible, view, "ResponsibleId", "Responsible",
                                  "( Todos los responsables )", String.Empty, String.Empty);
    }

    protected sealed override void SetRepeaterTemplates() {
      if (base.SelectedTabStrip == 0) {
        Func<DataRowView, string> Id = (x => Convert.ToString(x["ResponsibleId"]));
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/transactions/process.control.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/transactions/process.control.item.ascx");
        base.ViewColumnsCount = 4;
        base.LoadInboxesInQuickMode = true;
      } else if (base.SelectedTabStrip == 1) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/transactions/process.control.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/transactions/process.delivery.item.ascx");
        base.ViewColumnsCount = 4;
        base.LoadInboxesInQuickMode = true;
      } else if (base.SelectedTabStrip == 2) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/transactions/process.control.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/transactions/process.close.item.ascx");
        base.ViewColumnsCount = 4;
        base.LoadInboxesInQuickMode = true;
      } else if (base.SelectedTabStrip == 3) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/transactions/process.control.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/transactions/process.receive.item.ascx");
        base.ViewColumnsCount = 4;
        base.LoadInboxesInQuickMode = true;
      } else if (base.SelectedTabStrip == 4) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/transactions/process.control.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/transactions/process.control.item.ascx");
        base.ViewColumnsCount = 4;
        base.LoadInboxesInQuickMode = false;
      } else if (base.SelectedTabStrip == 5) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/transactions/process.search.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/transactions/process.search.item.ascx");
        base.ViewColumnsCount = 5;
        base.LoadInboxesInQuickMode = false;
      } else if (base.SelectedTabStrip == 6) {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/transactions/process.search.header.ascx");
        itemsRepeater.ItemTemplate = Page.LoadTemplate("~/templates/transactions/process.search.item.ascx");
        base.ViewColumnsCount = 5;
        base.LoadInboxesInQuickMode = false;
      } else {
        itemsRepeater.HeaderTemplate = Page.LoadTemplate("~/templates/empty.header.ascx");
      }
    }

    private void ChangeTransactionStatus() {
      LRSTransaction transaction = LRSTransaction.Parse(int.Parse(GetCommandParameter("id")));
      TransactionStatus status = (TransactionStatus) Convert.ToChar(GetCommandParameter("state"));
      string note = GetCommandParameter("notes", false);

      string s = transaction.ValidateStatusChange(status);
      if (!String.IsNullOrWhiteSpace(s)) {
        base.SetOKScriptMsg(s);
        return;
      }
      transaction.SetNextStatus(status, Person.Empty, note);

      base.SetOKScriptMsg();
      txtSearchExpression.Value = "";
      txtSearchExpression.Focus();
    }

    private void ReceiveLRSTransaction() {
      int transactionId = int.Parse(GetCommandParameter("id"));
      string notes = GetCommandParameter("notes", false);

      LRSTransaction transaction = LRSTransaction.Parse(transactionId);

      string s = transaction.ValidateStatusChange(TransactionStatus.Received);
      if (!String.IsNullOrWhiteSpace(s)) {
        base.SetOKScriptMsg(s);
        return;
      }
      transaction.Receive(notes);

      base.SetOKScriptMsg();
      txtSearchExpression.Value = "";
      txtSearchExpression.Focus();
    }

    private void TakeLRSTransaction() {
      int transactionId = int.Parse(GetCommandParameter("id"));
      string notes = GetCommandParameter("notes", false);

      LRSTransaction transaction = LRSTransaction.Parse(transactionId);
      transaction.Take(notes);

      base.SetOKScriptMsg();
      txtSearchExpression.Value = "";
      txtSearchExpression.Focus();
    }

    private void ReturnDocumentToMe() {
      int transactionId = int.Parse(GetCommandParameter("id"));

      LRSTransaction transaction = LRSTransaction.Parse(transactionId);
      transaction.ReturnToMe();

      base.SetOKScriptMsg();
      txtSearchExpression.Value = "";
      txtSearchExpression.Focus();
    }

    private string GetFilter() {
      string filter = String.Empty;
      if (cboProcessType.Value.Length != 0) {
        filter = "(TransactionTypeId = " + cboProcessType.Value + ")";
      }
      if (base.SelectedTabStrip != 3 && base.SelectedTabStrip != 4 && cboStatus.Value.Length != 0) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        filter += cboStatus.Value;
      }
      if (cboRecorderOffice.Value.Length != 0) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        filter += "(RecorderOfficeId = " + cboRecorderOffice.Value + ")";
      }
      if (base.SelectedTabStrip == 5 && cboResponsible.Value.Length != 0) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        filter += "(ResponsibleId = " + cboResponsible.Value + ")";
      }
      if (txtSearchExpression.Value.Length != 0) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        if (cboSearch.Value.Length == 0) {
          filter += SearchExpression.ParseAndLike("TransactionKeywords", txtSearchExpression.Value);
        } else {
          filter += SearchExpression.ParseAndLike(cboSearch.Value, txtSearchExpression.Value);
        }
      }
      if (cboElapsedTime.Value.Length != 0) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        filter += cboElapsedTime.Value;
      }
      if (cboDate.Value.Length != 0 && txtFromDate.Value.Length != 0) {
        if (filter.Length != 0) {
          filter += " AND ";
        }
        filter += "([" + cboDate.Value + "] >= '" + EmpiriaString.ToDate(txtFromDate.Value).ToString("yyyy-MM-dd") + "') AND " +
                  "([" + cboDate.Value + "] < '" + EmpiriaString.ToDate(txtToDate.Value).ToString("yyyy-MM-dd 23:59") + "')";
      }
      return filter;
    }

    #endregion Protected methods

  } // class ProcessControlDashboard

} // namespace Empiria.Web.UI.LRS