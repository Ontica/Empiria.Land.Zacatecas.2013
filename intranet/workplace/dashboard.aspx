<%@ Page Language="C#" MasterPageFile="~/workplace/default.master" CodeFile="dashboard.aspx.cs" Inherits="Empiria.Web.UI.Workplace.Dashboard" %>
<asp:Content ID="workArea" ContentPlaceHolderID="contentPlaceHolder" Runat="Server">
  <div class="dashboardItem" style="width:100%" style="display:<%=dashboardWebViewModel.Source != "~/workplace/empty.page.aspx" ? "inline" : "none" %>">
  <iframe id="ifraWorkarea" src="<%=ResolveClientUrl(dashboardWebViewModel.Source)%>" frameborder="no" hidefocus="hidefocus" 
					width="100%" height="436px" marginheight="0" marginwidth="0" scrolling="no" style="margin:0px;padding:0px;">
   </iframe>
  </div>
</asp:Content>