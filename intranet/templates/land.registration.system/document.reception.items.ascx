<%@ Import Namespace="Empiria.Presentation" %>
<%@ Import Namespace="Empiria.Government.LandRegistration" %>
<%@ Import Namespace="Empiria.Government.LandRegistration.UI" %>
<%# ((int) DataBinder.Eval(Container, "ItemIndex")) == 0 ? "<tbody>" : String.Empty %>
<tr class="<%# ((int) DataBinder.Eval(Container, "ItemIndex") % 2 == 0 ? String.Empty  : "oddDataRow") %>" onmouseover="dataGridRowSelect(this, true);" onmouseout="dataGridRowSelect(this, false);">
	<td style="white-space:nowrap;">
		<table class="ghostTable">
			<tr><td rowspan="5"><a href="javascript:doOperation('editTransaction', <%#DataBinder.Eval(Container, "DataItem.TransactionId")%>)"><img src="../themes/default/app.icons/documents.gif" alt='' title="Abre el tr�mite" style='margin-right:20px' /></a></td>
					<td colspan="2" style='width:100%;height:22px'><a id="ancRecordingBook<%#DataBinder.Eval(Container, "DataItem.TransactionId")%>" class="detailsLinkTitle" href="javascript:doOperation('editTransaction', <%#DataBinder.Eval(Container, "DataItem.TransactionId")%>)" title="Abre el tr�mite"><%#DataBinder.Eval(Container, "DataItem.TransactionKey")%></a></td></tr>
      <tr><td style="width:20px">Origen:&nbsp;</td><td><span class='boldItem'>Ventanilla</span></td></tr>
      <tr><td style="width:20px">Tipo:&nbsp;</td><td><span class='boldItem'>Inscripci�n</span></td></tr>
			<tr><td style="width:20px">Presentaci�n:&nbsp;</td><td><span class='boldItem'><%#((DateTime)DataBinder.Eval(Container, "DataItem.TransactionPresentationTime")).ToString("dd/MMM/yyyy HH:mm:ss")%></span></td></tr>
    </table>
	</td>
	<td style="white-space:nowrap;width:30%">
    <span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.TransactionRequestedBy")%></span><br /><br />
    EMail: <span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.TransactionRequestedByEMail")%></span><br /><br />
    Tels: <span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.TransactionRequestedByPhone")%></span>
    </td>
	<td style="white-space:normal;">
  <span class='boldItem'><%#((DateTime)DataBinder.Eval(Container, "DataItem.TransactionPresentationTime")).ToString("dd/MMM/yyyy HH:mm:ss")%></span></td>
	<td style="white-space:nowrap;">
	  <i>Aqu� ir� la descripci�n del documento</i>
	</td>
  <td style="white-space:normal;"><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.TransactionNotes")%></span></td>
	<td style="white-space:nowrap;width:40%">			
	  &nbsp;
	</td>
</tr>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).IsLastItem((int) DataBinder.Eval(Container, "ItemIndex")) ? "</tbody>" : String.Empty %>
