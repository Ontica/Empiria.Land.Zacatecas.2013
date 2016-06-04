<%@ Control Language="C#" AutoEventWireup="false" Inherits="Empiria.Web.UI.LRS.RecordingPaymentEditorControl" Codebehind="recording.payment.editor.control.ascx.cs" %>
<table id="oRecordingPaymentTable" class="editionTable" style="display:inline;">
  <tr>
    <td>Total pago derechos: &nbsp;&nbsp;$</td>
    <td>
    <input id="txtRecordingPayment" name="txtRecordingPayment" type="text" class="textBox" style="width:66px" 
    		     onkeypress="return positiveKeyFilter(this);" title="" maxlength="9" runat="server" />
    <select id="cboRecordingPaymentCurrency" name="cboRecordingPaymentCurrency" class="selectBox" style="width:52px" title="" runat="server">
      <option value="">(?)</option>
      <option value="600" title="Pesos mexicanos">MXN</option>
      <option value="ND" title="No determinado">N/D</option>
      <option value="NC" title="No consta">N/C</option>
      <option value="NL" title="No legible">N/L</option>
    </select>
    Boleta de pago:
    </td>
    <td>
    <input id="txtRecordingPaymentReceipt" name="txtRecordingPaymentReceipt" type="text" class="textBox" style="width:62px" 
           onkeypress="return notSpaceKeyFilter(this);" title="" maxlength="12" runat="server" />
    </td>
    <td>&nbsp;&nbsp;Otras boletas:</td>
    <td>
    <input id="txtRecordingPaymentAdditionalReceipts" name="txtRecordingPaymentAdditionalReceipts" type="text" class="textBox" 
           style="width:128px" title="" maxlength="36" runat="server" />
    </td>
    <td class="lastCell">&nbsp;</td>
  </tr>
</table>
<script type="text/javascript">
/* <![CDATA[ */
	
  function <%=this.ClientID%>_validate() {
    var sMsg = '';
    var oCurrency = getElement('<%=cboRecordingPaymentCurrency.ClientID%>');
    var oPayment = getElement('<%=txtRecordingPayment.ClientID%>');
    var oReceipt = getElement('<%=txtRecordingPaymentReceipt.ClientID%>');
    var otherReceipts = getElement('<%=txtRecordingPaymentAdditionalReceipts.ClientID%>');

    if (oCurrency.value.length == 0) {
      sMsg  = "Validación del pago de derechos.\n\n";
      sMsg += "No se ha seleccionado la moneda del pago de derechos.";
      alert(sMsg);
      return false;
    }
    if (oCurrency.value == 'ND' && oPayment.value.length != 0) {
      sMsg  = "Validación del pago de derechos.\n\n";
      sMsg += "Se seleccionó la opción NO DETERMINADO en el pago de derechos.\n\n";
      sMsg += "No obstante sí se proporcionó el importe de los mismos.";
      alert(sMsg);
      return false;
    }
    if (oCurrency.value == 'NL' && oPayment.value.length != 0) {
      sMsg  = "Validación del pago de derechos.\n\n";
      sMsg += "Se seleccionó la opción NO LEGIBLE en el pago de derechos.\n\n";
      sMsg += "Sin embargo sí se proporcionó el importe de los mismos.";
      alert(sMsg);
      return false;
    }
    if (oCurrency.value == 'NC' && oPayment.value.length != 0) {
      sMsg  = "Validación del pago de derechos.\n\n";
      sMsg += "Se seleccionó la opción NO CONSTA en el pago de derechos.\n\n";
      sMsg += "No obstante sí se proporcionó el importe de los mismos.";
      alert(sMsg);
      return false;
    }
    if (isNumeric(oCurrency) && oPayment.value.length == 0) {
      sMsg  = "Validación del pago de derechos.\n\n";
      sMsg += "Requiero se proporcione el importe total por pago de derechos.\n\n";
      alert(sMsg);
      return false;
    }
    if (isNumeric(oCurrency) && !isNumeric(oPayment)) {
      sMsg  = "Validación del pago de derechos.\n\n";
      sMsg += "No reconozco el importe total por pago de derechos.";
      alert(sMsg);
      return false;
    }
    if (isNumeric(oCurrency) && convertToNumber(oPayment.value) < 0) {
      sMsg  = "Validación del pago de derechos.\n\n";
      sMsg += "No reconozco importes por pago de derechos negativos.";
      alert(sMsg);
      return false;
    }
    if (isNumeric(oCurrency) && oReceipt.value.length == 0) {
      sMsg = "Validación del pago de derechos.\n\n";
      sMsg += "No se proporcionó la boleta de pago pero sí el importe\n";
      sMsg += "total por pago de derechos de inscripción.\n\n";
      sMsg += "¿El número de boleta de pago no es legible o no consta?";
      if (!confirm(sMsg)) {
        return false;
      }
    }
    if (0 < oReceipt.value.length && oReceipt.value.length < 6) {
      sMsg = "Validación del pago de derechos.\n\n";
      sMsg += "El número de boleta de pago contiene menos de seis caracteres.\n\n";
      sMsg += "¿El número de boleta está correcto?";
      if (!confirm(sMsg)) {
        return false;
      }
    }
    if (0 < otherReceipts.value.length && otherReceipts.value.length < 6) {
      sMsg = "Validación del pago de derechos.\n\n";
      sMsg += "Parece que la infromación de boletas adicionales está incompleta.\n\n";
      sMsg += "¿La información de las boletas adicionales es correcta?";
      if (!confirm(sMsg)) {
        return false;
      }
    }
    return true;
  }

  addEvent(getElement('<%=txtRecordingPaymentReceipt.ClientID%>'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('<%=txtRecordingPaymentAdditionalReceipts.ClientID%>'), 'keypress', upperCaseKeyFilter);

/* ]]> */
</script>