<%@ Import Namespace="Empiria.Presentation" %>
<%@ Import Namespace="Empiria.Government.LandRegistration" %>
<%@ Import Namespace="Empiria.Government.LandRegistration.UI" %>
<%@ Import Namespace="Empiria.Government.LandRegistration.Transactions" %>
<%# ((int) DataBinder.Eval(Container, "ItemIndex")) == 0 ? "<tbody>" : String.Empty %>
<tr class="<%# ((int) DataBinder.Eval(Container, "ItemIndex") % 2 == 0 ? String.Empty  : "oddDataRow") %>" onmouseover="dataGridRowSelect(this, true);" onmouseout="dataGridRowSelect(this, false);">
	<td style="width:20%">
		<table class="ghostTable">
			<tr><td rowspan="5"><a href="javascript:doOperation('editTransaction', <%#DataBinder.Eval(Container, "DataItem.TransactionId")%>)"><img src="../themes/default/app.icons/documents.gif" alt='' title="Abre el tr�mite" style='margin-right:20px' /></a></td>
				<td colspan="2" style='height:22px'><a id='ancTransactionKey<%#DataBinder.Eval(Container, "DataItem.TransactionId")%>' class="detailsLinkTitle" href="javascript:doOperation('editTransaction', <%#DataBinder.Eval(Container, "DataItem.TransactionId")%>)" title="Abre el tr�mite"><%#DataBinder.Eval(Container, "DataItem.TransactionKey")%></a>
					&nbsp;&nbsp;
          N�m doc: <a class="detailsLinkTitle" href="javascript:doOperation('showDocument', <%#DataBinder.Eval(Container, "DataItem.DocumentId")%>)" title="Muestra el documento"><%#DataBinder.Eval(Container, "DataItem.DocumentKey")%></a></td></tr>
      <tr><td style="width:20px">Tr�mite:&nbsp;</td><td width="70%"><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.TransactionType")%></span></td></tr>
      <tr><td style="width:20px">Documento:&nbsp;</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.DocumentType")%></span></td></tr>
      <tr><td style="">Distrito/Mesa: &nbsp; &nbsp; &nbsp;</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.RecorderOffice")%></span></td></tr>
      <tr><td>Estado actual:&nbsp;</td><td><span id='ancStatus<%#DataBinder.Eval(Container, "DataItem.TransactionId")%>' class='boldItem'><%#DataBinder.Eval(Container, "DataItem.CurrentTransactionStatusName")%></span>&nbsp;&nbsp;&nbsp;<a class="detailsLinkTitle"><%#DataBinder.Eval(Container, "DataItem.ControlNumber")%></a></td></tr>
    </table>
	</td>
	<td style="white-space:nowrap;width:30%">
		<table class="ghostTable">
      <tr><td style="width:100%; white-space:normal" colspan="2"><span id="ancRequestedBy<%#DataBinder.Eval(Container, "DataItem.TransactionId")%>" class='boldItem' style="width:100%; white-space:normal"><%#DataBinder.Eval(Container, "DataItem.RequestedBy")%></span></td></tr>
      <tr><td style="width:20px">Instrumento:&nbsp;</td><td width="90%"><span id="ancInstrument<%#DataBinder.Eval(Container, "DataItem.TransactionId")%>" class='boldItem'><%#((string)DataBinder.Eval(Container, "DataItem.DocumentNumber")).Length == 0 ? "No proporcionado" : DataBinder.Eval(Container, "DataItem.DocumentNumber") %></span></td></tr>
      <tr><td style="width:20px">Derechos:&nbsp;</td><td><span class='boldItem'><%#((decimal)DataBinder.Eval(Container, "DataItem.ReceiptTotal")).ToString("C2")%></span> &nbsp;&nbsp;R: <%#DataBinder.Eval(Container, "DataItem.ReceiptNumber")%></td></tr>
			<tr><td style="width:20px">Presentaci�n:&nbsp;</td><td><span class='boldItem'><%#((DateTime)DataBinder.Eval(Container, "DataItem.PresentationTime")) == Empiria.ExecutionServer.DateMaxValue ? "No presentado" : ((DateTime)DataBinder.Eval(Container, "DataItem.PresentationTime")).ToString("dd/MMM/yyyy HH:mm")%></span></td></tr>
      <tr><td style="white-space:nowrap">Siguiente estado:&nbsp;</td><td><span id="ancNextStatus<%#DataBinder.Eval(Container, "DataItem.TransactionId")%>" class='boldItem'><%#DataBinder.Eval(Container, "DataItem.NextTransactionStatusName")%></span>
      <span style=" display:none" id="ancNextStatusID<%#DataBinder.Eval(Container, "DataItem.TransactionId")%>"><%#DataBinder.Eval(Container, "DataItem.NextTransactionStatus")%></span>
      </td></tr>
    </table>
  </td>
	<td style="white-space:nowrap;width:40%">			
		<br />
	  <textarea id="txtNotes<%# DataBinder.Eval(Container, "DataItem.TransactionId")%>" class="textArea" rows="2" cols="45" style="width:280px"></textarea>
    <br />
    <input class="button" type="button" value="Recibir documentaci�n" onclick="doOperation('takeLRSTransaction', <%# DataBinder.Eval(Container, "DataItem.TransactionId")%>)" style="width:136px;height:34px" />
	</td>
</tr>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).IsLastItem((int) DataBinder.Eval(Container, "ItemIndex")) ? "</tbody>" : String.Empty %>
