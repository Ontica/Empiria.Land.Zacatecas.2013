<%@ Page language="c#" Inherits="Empiria.Government.LandRegistration.UI.LRSTransactionEditor" EnableViewState="true" EnableSessionState="true" Codebehind="transaction.editor.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head id="Head1" runat="server">
<title><%=GetTitle()%></title>
<meta http-equiv="Expires" content="-1" /><meta http-equiv="Pragma" content="no-cache" />
<link href="../themes/default/css/secondary.master.page.css" type="text/css" rel="stylesheet" />
<link href="../themes/default/css/editor.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="../scripts/empiria.ajax.js"></script>
<script type="text/javascript" src="../scripts/empiria.general.js"></script>
<script type="text/javascript" src="../scripts/empiria.secondary.master.page.js"></script>
<script type="text/javascript" src="../scripts/empiria.validation.js"></script>
<script type="text/javascript" src="../scripts/empiria.calendar.js"></script>
</head>
<body>
<form id="aspnetForm" method="post" runat="server">
<div>
<input type="hidden" name="hdnPageCommand" id="hdnPageCommand" runat="server" />
</div>
<div id="divCanvas">
  <div id="divHeader">
    <span class="appTitle">
      <%=GetTitle()%>
    </span>
    <span class="rightItem">
    </span>
  </div>
  <div id="divBody">
    <div id="divContent">

  <table class="tabStrip">
    <tr>
      <td id="tabStripItem_0" class="tabOn" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);"  onclick="doCommand('onClickTabStripCmd', this);" title="">Información del trámite</td>
      <td id="tabStripItem_1" class="tabOff" style="display:none" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Actos jurídicos y conceptos</td>
      <td id="tabStripItem_2" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Inscripción de documentos</td>
      <td id="tabStripItem_3" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Emisión de certificados</td>
      <td id="tabStripItem_4" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Historia del trámite</td>
      <td class="lastCell" colspan="1" rowspan="1"><a id="top" />&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
    </tr>
  </table>
  <table id="tabStripItemView_0" class="editionTable" style="display:inline">
    <tr>
      <td class="subTitle">Información del trámite y descripción del documento</td>
    </tr>
    <tr>
    <td>
      <table id="transactionEditor0" class="editionTable">
        <tr>
          <td>Número de trámite:</td>
          <td><input id='txtTransactionKey' type="text" class="textBox" readonly="readonly" style="width:220px;" title="" runat="server" /></td>
          <td>Distrito destino:</td>
          <td class="lastCell">
            <select id="cboRecorderOffice" class="selectBox" style="width:224px" onchange="return updateUserInterface(this);" runat="server">				  
              <option value="">( Seleccionar )</option>
              <option value="101">Zacatecas</option>
              <option value="102">Fresnillo</option>
              <option value="103">Jerez</option>
              <option value="104">Río Grande</option>
              <option value="105">Sombrerete</option>
              <option value="106">Tlaltenango</option>
              <option value="107">Calera</option>
              <option value="108">Concepción del Oro</option>
              <option value="109">Jalpa</option>
              <option value="110">Juchipila</option>
              <option value="111">Loreto</option>
              <option value="112">Miguel Auza</option>
              <option value="113">Nochistlán</option>
              <option value="114">Ojocaliente</option>
              <option value="115">Pinos</option>
              <option value="116">Teúl de González Ortega</option>
              <option value="117">Valparaíso</option>
              <option value="118">Villanueva</option>
            </select>
          </td>
        </tr>
        <tr>
          <td>Categoría del trámite:</td>
          <td>
            <select id="cboDocumentType" class="selectBox" style="width:226px" onchange="return updateUserInterface(this);" runat="server">
              <option value="">( Seleccionar )</option>
            </select>
          </td>
          <td>
            Num Escritura/Doc:
          </td>
          <td class="lastCell"><input id='txtDocumentNumber' type="text" class="textBox" style="width:218px;" title="" maxlength="48" runat="server" /></td>
        </tr>
        <tr style='display:<%=transaction.Status != Empiria.Government.LandRegistration.Transactions.TransactionStatus.Payment ? "inline" : "none"%>'>
          <td>Fecha de presentación:</td>
          <td>
            <input id='txtPresentationDate' type="text" class="textBox" style="width:106px;" readonly="readonly" title="" maxlength="128" runat="server" />
            &nbsp;
            Control: <input id='txtControlNumber' type="text" class="textBox" readonly="readonly" style="width:50px;" title="" runat="server" />
          </td>
          <td>Recibido por:</td>
          <td class="lastCell">
            <input id='txtReceivedBy' type="text" class="textBox" readonly="readonly" style="width:218px;" title="" maxlength="128" runat="server" />
           </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td class="subTitle">Información del interesado</td>
  </tr>
   <tr>
    <td>
      <table class="editionTable">
        <tr>
          <td>Notario/Gestor:</td>
          <td>
            <select id="cboManagementAgency" class="selectBox" style="width:266px" onchange="return updateUserInterface(this);" runat="server">
              <option value="-1">( No determinado )</option>
              <option value="505">NOT 9</option>
              <option value="511">NOT 26</option>              
            </select>
          </td>
          <td colspan="2" class="lastCell" valign="middle">
            <input id="cmdUseManagementAgencyAsRequestedBy" class="button" type="button" value="Copiar como interesado" onclick="doOperation('copyManagementAgencyAsRequestedBy')" style="height:24px;width:140px" disabled="disabled" />
          </td>
        </tr>
        <tr>
          <td>Interesado(s):<br /><br />&nbsp;</td>
          <td><textarea id='txtRequestedBy' class="textArea" rows="3" cols="128" style="width:260px;" title="" runat="server"></textarea></td>
          <td>Observaciones:<br /><br />&nbsp;</td>
          <td class="lastCell"><textarea id="txtRequestNotes" class="textArea" style="width:260px" cols="128" rows="3" runat="server"></textarea></td>
        </tr>
        <tr style="display:none">
          <td>Correo electrónico:</td>
          <td colspan="3" class="lastCell">
            <input id='txtContactEMail' type="text" class="textBox" style="width:189px;" title="" runat="server" />
            Teléfonos:
            <input id='txtContactPhone' type="text" class="textBox" style="width:168px;" title="" runat="server" />
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr style="display:<%=base.ShowConceptsGrid() ? "inline" : "none"%>">
    <td class="subTitle">Conceptos</td>
  </tr>
  <tr style="display:<%=base.ShowConceptsGrid() ? "inline" : "none"%>">
    <td>
      <table class="editionTable">
        <tr>
          <td colspan="8" class="lastCell">
            <div style="overflow:auto;width:98%;">
              <table class="details" style="width:99%">
                <tr class="detailsHeader">
                  <td>#</td>
                  <td>Concepto</td>
                  <td align='right'>Base gravable</td>
                  <td align='right'>Cantidad</td>
                  <td>Unidad medida</td>
                  <td>Fundamento</td>
                  <td>Observaciones</td>
                  <td>Recibo</td>
                  <td>Importe</td>
                  <td align='right'>&nbsp;</td>
                </tr>
                <%=base.GetRecordingActs()%>
              </table>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr id="divConceptEditor" style='display:<%=base.ShowConceptEditor() ? "inline" : "none"%>'>
    <td>
      Tipo:
      <select id="cboRecordingActTypeCategory" class="selectBox" style="width:230px" onchange="return updateUserInterface(this);" runat="server">
        <option value="-1">( Seleccionar )</option>
        <option value="1047">Conceptos generales</option>
        <option value="1048">Expedición de certificados y copias</option>
        <option value="1049">Comercio</option>
        <option value="1050">Catastro</option>
        <option value="1051">Traslativos de dominio</option>
        <option value="1053">Decretos y fideicomisos</option>
        <option value="1063">Subdivisiones y fusiones</option>
        <option value="1054">Actos de servidumbre</option>
        <option value="1055">Rectificaciones</option>
        <option value="1056">Fraccionamientos rurales</option>
        <option value="1057">Anotaciones directas en la escritura</option>
        <option value="1064">Hipotecas</option>
        <option value="1069">Embargos y fianzas</option>
        <option value="1068">Cr&#233;ditos agr&#237;colas</option>
        <option value="1065">Notas marginales</option>
      </select>
      Concepto:
      <select id="cboRecordingActType" class="selectBox" style="width:382px" onchange="return updateUserInterface(this);" runat="server">
        <option value="">( Seleccionar el concepto )</option>
      </select>
      <br />
      Base gravable:
      <input id='txtOperationValue' type="text" class="textBox" onkeypress="return positiveKeyFilter(this);" style="width:71px;" title="" maxlength="16" runat="server" />
      <select id="cboOperationValueCurrency" class="selectBox" style="width:52px;margin-left:-6px" runat="server">
        <option value="">(?)</option>
        <option value="600" title="Pesos mexicanos">MXN</option>
        <option value="603" title="Salarios mínimos">SM</option>
        <option value="602" title="Unidades de inversión">UDIS</option>
      </select>

      Cantidad:
      <input id='txtQuantity' type="text" class="textBox" onkeypress="return positiveKeyFilter(this);" style="width:32px;" title="" maxlength="8" runat="server" />
      Unidad:
      <select id="cboUnit" class="selectBox" style="width:106px" onchange="return updateUserInterface(this);" runat="server">
        <option value="-1">No aplica</option>
        <option value="641">Fojas</option>
        <option value="652">Copias</option>
        <option value="642">Anotaciones</option>
        <option value="643">Gravámenes</option>
        <option value="644">Lotes</option>
        <option value="645">Predios</option>
        <option value="646">Testimonios</option>
        <option value="647">Documentos</option>
        <option value="648">Inscripciones</option>
        <option value="640">Certificados</option>
        <option value="649">Actos</option>	
      </select>
      Fundamento:
      <select id="cboLawArticle" class="selectBox" style="width:160px" onchange="return updateUserInterface(this);" runat="server">
        <option value="">( Fundamento )</option>
      </select>
      <br />
      Observaciones:
      <input id='txtConceptNotes' type="text" class="textBox" style="width:380px;" title="" runat="server" />
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      <input id="cmdAddConcept" class="button" type="button" value="Agregar concepto" onclick="doOperation('saveConcept')" style="top:6px;height:26px;width:120px" runat="server" />
    </td>
  </tr>
  <tr id='divReceiptEditor' style="display:none">
    <td>Recibo de pago:
      <input id='txtReceiptNumber' type="text" class="textBox" style="width:154px;" title="" maxlength="24" runat="server" />
      <img src="../themes/default/buttons/search.gif" alt="" title="Busca un número de recibo" style="margin-left:-4px" onclick="doOperation('validateReceiptWS')" />
      &nbsp; 
      Importe del recibo:&nbsp; &nbsp;
      <b>$</b>&nbsp;<input id='txtReceiptTotal' type="text" class="textBox" onkeypress="return positiveKeyFilter(this);" style="width:71px;" title="" maxlength="9" runat="server" />
      <input class="button" type="button" value="Aplicar recibo" onclick="doOperation('applyReceipt')" style="height:26px;width:120px" runat="server" />
    </td>
  </tr>
</table>

<table id="tabStripItemView_2" class="editionTable" style="display:none">
  <tr>
    <td class="lastCell">
      <iframe id="ifraRecordingEditor" style="z-index:99;left:0px;top:0px;" 
              marginheight="0" marginwidth="0" frameborder="0" scrolling="no"
              src="../workplace/empty.page.aspx" width="90%" visible="true" >
      </iframe>
    </td>
  </tr> 
</table>

<table id="tabStripItemView_3" class="editionTable" style="display:none">
  <tr>
    <td class="subTitle">Certificados emitidos</td>
  </tr>
  <tr>
    <td>
      <div style="overflow:auto;width:100%;">
        <table class="details" style="width:97%">
          <tr class="detailsHeader">
            <td>#Certif</td>
            <td>Tipo de certificado</td>
            <td>Predio</td>
            <td>Interesado</td>
            <td>Elaborado por</td>
            <td>Estado</td>
            <td width="40%">Observaciones</td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
</table>

    <table id="tabStripItemView_4" class="editionTable" style="display:none">
        <tr>
          <td class="subTitle">Historia del trámite</td>
        </tr>
        <tr>
          <td>
            <div style="overflow:auto;width:100%;">
              <table class="details" style="width:97%">
                <tr class="detailsHeader">
                  <td>Tipo de movimiento</td>
                  <td>Responsable</td>
                  <td>Recibido</td>
                  <td>Terminado</td>
                  <td>Entregado</td>
                  <td>Trabajo</td>
                  <td>Estado</td>
                  <td width="40%">Observaciones</td>
                </tr>
                <%=GetTransactionTrack()%>
              </table>
            </div>
          </td>
        </tr>
     </table>
  </div>
      </div> <!-- end divBody !-->  
      <div id="divBottomToolbar" style="height:48px; float:none">
        <table class="editionTable"><tr><td>
        <% if (!transaction.IsNew) { %>
          <input class="button" type="button" value="Crear nuevo" onclick="doOperation('createNew')" style="height:30px;width:82px" runat="server" />
          &nbsp; &nbsp;
          <input class="button" type="button" value="Crear copia" onclick="doOperation('createCopy')" style="height:30px;width:82px" runat="server" />
          <img src="../themes/default/bullets/pixel.gif" width="64px" height="1px" alt='' />
          <% if (base.CanPrintPayment()) { %>
            <input class="button" type="button" value="Orden de pago" onclick="doOperation('printPaymentOrder')" style="height:30px;width:90px" runat="server" />
          <% } else if (base.CanPrintReceipt()) { %>
            <input class="button" type="button" value="Boleta de Recepción" onclick="doOperation('printTransactionReceipt')" style="height:30px;width:110px" runat="server" />
          <% } %>
        <% } else { %>
          <img src="../themes/default/bullets/pixel.gif" width="64px" height="1px" alt='' />
        <% } %>
        <img src="../themes/default/bullets/pixel.gif" width="48px" height="1px" alt='' />
        <% if (base.CanReceiveTransaction()) { %>
        <input id="cmdSaveAndReceive" class="button" type="button" value="Recibir trámite" onclick="doOperation('saveAndReceive')" style="height:30px;width:100px" runat="server" />
        <% } %>
        <% if (transaction.ReadyForReentry) { %>
        <input class="button" type="button" value="Reingresar trámite" onclick="doOperation('reentryTransaction')" style="height:30px;width:100px" runat="server" />
        <% } %>
        <input id="cmdSaveTransaction" class="button" type="button" value="Crear la solicitud" onclick="doOperation('saveTransaction')" style="height:30px;width:110px" runat="server" />
        </td></tr></table>
      </div> <!-- end divBottomToolbar !-->
    </div> <!-- end divCanvas !-->
  </form>
  <iframe id="ifraCalendar" style="z-index: 99; LEFT: 0px; visibility: hidden; position: absolute; TOP: 0px" 
          hspace="0px" vspace="0" marginheight="0"  marginwidth="0" frameborder="0" scrolling="no" 
          src="../user.controls/calendar.aspx" width="100%">
  </iframe>
</body>
  <script type="text/javascript">
  /* <![CDATA[ */
  
  function doPageCommand(commandName, commandArguments) {
    switch (commandName) {
      default:
        return false;
    }
  }

  function doOperation(command) {
    var success = false;

    if (gbSended) {
      return;
    }
    switch (command) {
      case 'redirectThis':
        success = true;
        break;
      case 'goToTransaction':
        sendPageCommand("goToTransaction", "id=" + arguments[1]);
        return;
      case 'saveTransaction':
        return saveTransaction();
      case 'saveAndReceive':
        return saveAndReceiveTransaction();
      case 'reentryTransaction':
        return reentryTransaction();
      case 'createCopy':
        return createCopy();
      case 'appendRecordingAct':
        return appendRecordingAct();
      case 'deleteRecordingAct':
        return deleteRecordingAct(arguments[1]);
      case 'printPaymentOrder':
        return printPaymentOrder(arguments[1]); 
      case 'printTransactionReceipt':
        return printTransactionReceipt(arguments[1]);
      case 'savePayment':
        return savePayment();
      case 'cancelTransaction':
        success = true;
        break;
      case 'createNew':
        return createNew();
      case 'showConcept':
        showConceptEditor();
        return;
      case 'showCertificateEditor':
        showCertificateEditor();
        return;
      case 'showReceipt':
        getElement('divConceptEditor').style.display = 'none';
        if (getElement('divReceiptEditor').style.display == 'none') {        
          getElement('divReceiptEditor').style.display = 'inline';
        } else {
          getElement('divReceiptEditor').style.display = 'none';
        }
        return;
      case 'saveConcept':
        return saveConcept();
      case 'applyReceipt':
        return applyReceipt();
      case 'printTransaction':
        return printTransaction();
      case 'printTransactionReceipt':
        return printTransactionReceipt();
      case 'searchCadastralNumber':
        alert("La búsqueda de claves catastrales no está disponible en este momento.");
        return;
      case 'searchGeographicalItems':
        return searchGeographicalItems();
      case 'setNoNumberLabel':
        getElement("txtExternalNumber").value = "S/N";
        return;
      case "copyManagementAgencyAsRequestedBy":
        copyManagementAgencyAsRequestedBy();
        return;
      case 'closeWindow':
        window.parent.execScript("doOperation('refreshRecording')");
        return;
      case 'appendGeographicalItem':
        return appendGeographicalItem();
      default:
        alert("La operación '" + command + "' no ha sido definida en el programa.");
        return;
    }
    if (success) {
      sendPageCommand(command);
      gbSended = true;
    }
  }

  function showConceptEditor() {
    getElement('divConceptEditor').style.display = (getElement('divConceptEditor').style.display == 'none') ? 'inline' : 'none';
  }

  function showCertificateEditor() {
    getElement('divCertificateEditor').style.display = (getElement('divCertificateEditor').style.display == 'none') ? 'inline' : 'none';
  }

  function reentryTransaction() {
    var sMsg = "Reingreso de trámites.\n\n";

    sMsg += "Esta operación reinigresará este trámite y lo enviará al distrito o mesa de trabajo correspondiente.\n\n";
    sMsg += "¿Reingreso este trámite"; 
    if (confirm(sMsg)) {
      sendPageCommand("reentryTransaction");
    }
  }

  function copyManagementAgencyAsRequestedBy() {    
    var oText = getElement('txtRequestedBy');

    if (oText.value.length == 0) {
      getElement('txtRequestedBy').value = getComboOptionText(getElement('cboManagementAgency')).toUpperCase();
      return;
    }
    var sMsg = "Esta operación modificará el nombre del interesado.\n\n";
    var sMsg = "¿Copio el nombre del notario o gestor al nombre del interesado?";
    if (confirm(sMsg)) {
      getElement('txtRequestedBy').value = getComboOptionText(getElement('cboManagementAgency')).toUpperCase();
      return;
    }
  }

  function deleteRecordingAct(transactionActId) {
    var sMsg = "Eliminación de actos jurídicos y conceptos de pago.\n\n";

    sMsg += "Esta operación eliminará el siguiente elemento de la lista de conceptos:\n\n";
    sMsg += "Línea:\n";
    sMsg += "Concepto:\n";
    sMsg += "¿Elimino el concepto de la lista?";

    if (confirm(sMsg)) {
      sendPageCommand("deleteRecordingAct", "id=" + transactionActId);
    }
  }

  function createNew() {
    window.location.replace("transaction.editor.aspx?id=0&typeId=<%=base.transaction.TransactionType.Id%>");
  }

  function printTransaction() {
    if (!doValidation("printTransaction")) {
      return;
    }
    sendPageCommand("printTransaction");
  }

  function printPaymentOrder() {
    if (!doValidation("printPaymentOrder")) {
      return;
    }
    sendPageCommand("printPaymentOrder");
  }

  function printTransactionReceipt() {
    if (!doValidation("printTransactionReceipt")) {
      return;
    }
    var url = "transaction.receipt.aspx?id=<%=base.transaction.Id%>";

    createNewWindow(url);
  }

  function saveTransaction() {
    if (!doValidation("saveTransaction")) {
      return;
    }
    if (!doSendMsg("saveTransaction")) {
      return;
    }
    sendPageCommand("saveTransaction");
    gbSended = true;
  }

  function saveAndReceiveTransaction() {
    if (!doValidation("saveAndReceiveTransaction")) {
      return;
    }
    if (!doSendMsg("saveAndReceiveTransacion")) {
      return;
    }
    sendPageCommand("saveAndReceiveTransaction");
  }

  function saveConcept() {
    if (!validateConcept()) {
      return;
    }
    var sMsg = "Agregar un concepto al trámite.\n\n";

    sMsg += getComboOptionText(getElement('cboRecordingActType')) + "\n";
    if (getElement('txtOperationValue').value.length != 0) {
      sMsg += "Base gravable:\t" + formatAsCurrency(getElement('txtOperationValue').value) + " " +
            getComboOptionText(getElement("cboOperationValueCurrency")) + "\n";
    }
    if (getElement('cboUnit').value != "-1") {
      sMsg += "Cantidad:\t\t" + getElement('txtQuantity').value + " " + getComboOptionText(getElement('cboUnit')) + "\n";
    }
    sMsg += "Fundamento:\t" + getComboOptionText(getElement('cboLawArticle')) + "\n\n";

    sMsg += "¿Agrego este concepto al trámite?";
    if (confirm(sMsg)) {
      sendPageCommand("appendConcept");
    }
  }

  function applyReceipt() {
    if (getElement('txtReceiptNumber').value.length == 0) {
      alert("Requiero se proporcione el número de recibo o línea de captura.");
      return false;
    }
    if (getElement('txtReceiptTotal').value.length == 0) {
      alert("Requiero se proporcione el importe del recibo.");
      return false;
    }
    if (getElement('txtReceiptTotal').value.length == 0) {
      alert("Requiero se proporcione el importe del recibo.");
      return false;
    }
    if (!isNumeric(getElement('txtReceiptTotal'))) {
      alert("No reconozco el importe total por pago de derechos.");
      return false;
    }
    if (convertToNumber(getElement('txtReceiptTotal').value) < 0) {
      alert("El importe por pago de derechos debe ser mayor o igual a cero.");
      return false;
    }
    var sMsg = "Aplicación de recibo de pago.\n\n";    
    sMsg += "Número de recibo:\t" + getElement('txtReceiptNumber').value + "\n";
    sMsg += "Pago de derechos:\t" + formatAsCurrency(getElement('txtReceiptTotal').value) + "\n\n";
    sMsg += "¿Aplico el recibo de pago a este trámite?";

    if (confirm(sMsg)) {
      sendPageCommand("applyReceipt");
    }
  }

  function validateConcept() {
    if (getElement('cboRecordingActType').value.length == 0) {
      alert("Requiero se proporcione un concepto de la lista.");
      return false;
    }
    if (getElement('cboLawArticle').value.length == 0) {
      alert("Requiero se proporcione el fundamento legal del cobro.");
      return false;
    }
    if (getElement('txtOperationValue').value.length != 0) {
      if (!validateQuantity(getElement('txtOperationValue'), "Base gravable")) {
        return false;
      }
      if (getElement("cboOperationValueCurrency").value.length == 0) {
        alert("Requiero se proporcione la moneda en la que está expresada la base gravable.");
        return false;
      }
    }
    if (getElement('txtQuantity').value.length != 0) {
      if (!validateQuantity(getElement('txtQuantity'), "Cantidad")) {
        return false;
      }
    }
    if (getElement('txtQuantity').value.length != 0 && getElement('cboUnit').value == "-1") {
      alert("Si se proporciona la cantidad requiero también la unidad de medida.");
      return false;
    }
    if (getElement('cboUnit').value != "-1" && getElement('txtQuantity').value.length == 0) {
      alert("Debido a que la unidad de medida es distinta a 'No aplica', necesito se proporcione la cantidad.");
      return false;
    } else if (getElement('cboUnit').value.length == "-1" && getElement('txtQuantity').value.length != 0) {
      alert("Necesito la unidad de medida de la cantidad proporcionada.");
      return false;
    }
    return true;
  }


  function appendRecordingAct() {
    if (!doValidateRecordingAct()) {
      return;
    }
    var sMsg = "Concepto:\t\t" + getComboOptionText(getElement('cboRecordingActType')) + "\n"; 
    sMsg += "Fundamento:\t\t" + getComboOptionText(getElement('cboLawArticle')) + "\n"; 
    sMsg += "Número de recibo:\t\t" + getComboOptionText(getElement('cboReceipts')) + "\n"; 
    sMsg += "Valor de la operación:\t" + formatAsCurrency(getElement('txtOperationValue').value);
    
    sMsg += "Derechos registrales:\t\t" + formatAsCurrency(getElement('txtRecordingRightsFee').value) + "\n";

    if (convertToNumber(getElement('txtSheetsRevisionFee').value) != 0) {
      sMsg += "Cotejo:\t\t\t" + formatAsCurrency(getElement('txtSheetsRevisionFee').value) + "\n";
    }
    if (convertToNumber(getElement('txtAclarationFee').value) != 0) {
      sMsg += "Aclaración:\t\t" + formatAsCurrency(getElement('txtAclarationFee').value) + "\n";
    }
    if (convertToNumber(getElement('txtUsufructFee').value) != 0) {
      sMsg += "Usufructo:\t\t\t" + formatAsCurrency(getElement('txtUsufructFee').value) + "\n";
    }
    if (convertToNumber(getElement('txtServidumbreFee').value) != 0) {
      sMsg += "Servidumbre:\t\t" + formatAsCurrency(getElement('txtServidumbreFee').value) + "\n";
    }
    if (convertToNumber(getElement('txtSignCertificationFee').value) != 0) {
      sMsg += "Certificación firmas:\t\t" + formatAsCurrency(getElement('txtSignCertificationFee').value) + "\n";
    }
    if (convertToNumber(getElement('txtForeignRecordFee').value) != 0) {
      sMsg += "Foráneo:\t\t\t" + formatAsCurrency(getElement('txtForeignRecordFee').value) + "\n";
    }
    sMsg += "\n";
    if (convertToNumber(getElement('txtDiscount').value) == 0) {
      sMsg += "Total:\t\t\t" + formatAsCurrency(getTotal()) + "\n";
    } else {
      sMsg += "Subtotal:\t\t\t" + formatAsCurrency(getSubTotal()) + "\n";
      sMsg += "Descuento:\t\t" + formatAsCurrency(getElement('txtDiscount').value) + "\n";
      sMsg += "Total:\t\t\t" + formatAsCurrency(getTotal()) + "\n";
    }
    sMsg += "\n";
    sMsg += "¿Agrego el acto jurídico y la información del pago de derechos?";
    if (confirm(sMsg)) {
      sendPageCommand("appendRecordingAct");
    }
  }

  function doValidateRecordingAct() {
    if (getElement('cboRecordingActType').value.length == 0) {
      alert("Requiero se proporcione el acto jurídico.");
      return false;
    }
    if (getElement('cboLawArticle').value.length == 0) {
      alert("Requiero se proporcione el fundamento del cobro.");
      return false;
    }
    if (getElement('cboReceipts').length > 1 && getElement('cboReceipts').value.length == 0 && getElement('txtRecordingActReceipt').value.length == 0) {
      alert("Necesito se introduzca el número de recibo adicional.");
      return false;
    } else if (getElement('cboReceipts').length == 1 && getElement('cboReceipts').value.length == 0 && getElement('txtRecordingActReceipt').value.length == 0) {
      getElement('txtRecordingActReceipt').value = "N/D";
    }
    if (!validateQuantity(getElement('txtOperationValue'), "Valor de la operación")) {
      return false;
    }
    if (!validateQuantity(getElement('txtRecordingRightsFee'), "Derechos de registro")) {
      return false;
    }
    if (!validateQuantity(getElement('txtSheetsRevisionFee'), "Cotejo")) {
      return false;
    }
    if (!validateQuantity(getElement('txtAclarationFee'), "Aclaración")) {
      return false;
    }
    if (!validateQuantity(getElement('txtUsufructFee'), "Usufructo")) {
      return false;
    }
    if (!validateQuantity(getElement('txtServidumbreFee'), "Servidumbre")) {
      return false;
    }
    if (!validateQuantity(getElement('txtSignCertificationFee'), "Certificación de firmas")) {
      return false;
    }
    if (!validateQuantity(getElement('txtForeignRecordFee'), "Trámite foráneo")) {
      return false;
    }
    if (!validateQuantity(getElement('txtDiscount'), "Descuento")) {
      return false;
    }
    getElement('txtSubtotal').value = getSubTotal();
    getElement('txtTotal').value = getTotal();

    if (convertToNumber(getElement('txtTotal').value) < 0) {
      alert("El importe total del acto no puede ser menor que cero.");
      return false;
    }
    return true;
  }

  function getSubTotal() {
    var subtotal = Number();

    subtotal = 0;

    subtotal += convertToNumber(getElement('txtRecordingRightsFee').value);
    subtotal += convertToNumber(getElement('txtSheetsRevisionFee').value);
    subtotal += convertToNumber(getElement('txtAclarationFee').value);
    subtotal += convertToNumber(getElement('txtUsufructFee').value);
    subtotal += convertToNumber(getElement('txtServidumbreFee').value);
    subtotal += convertToNumber(getElement('txtSignCertificationFee').value);
    subtotal += convertToNumber(getElement('txtForeignRecordFee').value);

    return subtotal;
  }

  function getTotal() {
    return getSubTotal() - convertToNumber(getElement('txtDiscount').value);
  }

  function validateQuantity(oElement, elementName) {
   if (oElement.value.length == 0) {
      oElement.value = "0.00";
      return true;
    }
    if (!isNumeric(oElement)) {
      alert("No reconozco el importe de " + elementName + ".");
      return false;
    }
    if (convertToNumber(oElement.value) < 0) {
      alert("El importe de " + elementName + " debe ser mayor o igual a cero.");
      return false;
    }
    return true;
  }
  
  function doSendMsg(command) {
    var sMsg = "";

    sMsg += "Tipo de trámite:\t<%=base.transaction.TransactionType.Name%>\n";
    sMsg += "Número de trámite:\t" + getElement('txtTransactionKey').value + "\n";
    sMsg += "Categoría:\t\t" + getComboOptionText(getElement('cboDocumentType')) + "\n";
    sMsg += "Núm instrumento:\t" + getElement('txtDocumentNumber').value + "\n\n";
    if  (command == "saveAndReceiveTransacion") {
      sMsg += "Número de recibo:\t" + getElement('txtReceiptNumber').value + "\n";
      sMsg += "Pago de derechos:\t" + formatAsCurrency(getElement('txtReceiptTotal').value) + "\n\n";
    }
    sMsg += "Interesado: " + getElement('txtRequestedBy').value + "\n\n";

    if (command == "saveTransaction") {
    <% if (base.transaction.IsNew) { %>
    sMsg = "Crear una nueva solicitud de trámite.\n\n" + sMsg;
    sMsg += "¿Creo este nuevo trámite con la información proporcionada?";
    <% } else { %>
    sMsg = "Modificar la solicitud de trámite " + getElement('txtTransactionKey').value + ".\n\n" + sMsg;
    sMsg += "¿Modifico la información de este trámite?";
    <% } %>
    } else if (command == "saveAndReceiveTransacion") {
    <% if (base.transaction.IsNew) { %>
    sMsg = "Crear y recibir una nueva solicitud de trámite.\n\n" + sMsg;
    sMsg += "¿Creo este nuevo trámite y lo marco como recibido?";
    <% } else { %>
    sMsg = "Modificar y recibir la solicitud de trámite " + getElement('txtTransactionKey').value + ".\n\n" + sMsg;
    sMsg += "¿Modifico la información de este trámite y lo marco como recibido?";
    <% } %>
    } else if (command == "copyTransaction") {
    sMsg = "Crear una copia de este trámite.\n\n" + sMsg;
    sMsg += "¿Creo una copia con la información de este trámite?";
    }
    return confirm(sMsg);
  }

  function createCopy() {
    if (doSendMsg('copyTransaction')) {
      sendPageCommand("copyTransaction");
    } 
  }

  function updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement("cboRecordingActTypeCategory")) {
      resetRecordingsTypesCombo();
    } else if (oControl == getElement("cboRecordingActType")) {
      resetLawArticlesCombo();
    } else if (oControl == getElement("cboManagementAgency")) {
      getElement("cmdUseManagementAgencyAsRequestedBy").disabled = (getElement("cboManagementAgency").value == "-1");
    }
  }

  function resetRecordingsTypesCombo() {    
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingTypesStringArrayCmd";
    url += "&recordingActTypeCategoryId=" + getElement("cboRecordingActTypeCategory").value; 

    invokeAjaxComboItemsLoader(url, getElement("cboRecordingActType"));

    resetLawArticlesCombo();
  }

  function resetLawArticlesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getLawArticlesStringArrayCmd";
    url += "&recordingActTypeId=" + getElement("cboRecordingActType").value; 

    invokeAjaxComboItemsLoader(url, getElement("cboLawArticle"));
  }

  function doValidation(command) {
    var sMsg = "";
    var oPayment = getElement('txtReceiptTotal');

    if (isEmpty(getElement('cboRecorderOffice'))) {
      alert("Requiero se proporcione la oficialía o distrito destino del trámite."); 
      return false;
    }
    if (isEmpty(getElement('cboDocumentType'))) {
      alert("Requiero se proporcione el tipo de documento que se desea inscribir."); 
      return false;
    }
    if (isEmpty(getElement('txtRequestedBy'))) {
      alert("Requiero se proporcione el nombre del solicitante."); 
      return false;
    }
    if (command == 'saveAndReceiveTransaction') {
      if (isEmpty(getElement('txtReceiptNumber'))) {
        alert("Requiero se proporcione el número del recibo emitido para este trámite.");
        return false;
      }
      if (!isNumeric(oPayment)) {
        alert("No reconozco el importe total por pago de derechos.");
        return false;
      }
      if (convertToNumber(oPayment.value) < 0) {
        alert("El importe por pago de derechos debe ser mayor o igual a cero.");
        return false;
      }
    }
    return true;
  }

  function window_onload() {
    setWorkplace();
    <%=base.OnloadScript()%>
    <% if (!base.transaction.IsNew && !base.transaction.IsEmptyInstance) { %>
      getElement('ifraRecordingEditor').src = "../land.registration.system/recording.editor.aspx?transactionId=<%=transaction.Id%>";
    <% } else { %>
      getElement('ifraRecordingEditor').src = "../workplace/empty.page.aspx";
    <% } %>
    <% if (!base.transaction.IsNew) { %>
    //disableControls(getElement("transactionEditor0"), true);
    //disableControls(getElement("transactionEditor1"), true);
    <% } else { %>

    <% } %>
  }
  function setWorkplace2() {
    resizeWorkplace2();
    setObjectEvents();
    window.defaultStatus = '';
  }

  function resizeWorkplace2() {

  }

  function window_onscroll() {

  }

  function ifraRecordingEditor_onresize() {
    var oFrame = getElement("ifraRecordingEditor");
    var oBody = oFrame.document.body;

    var newHeight = oBody.scrollHeight + oBody.clientHeight;

    oFrame.style.height = oBody.scrollHeight + (oBody.offsetHeight - oBody.clientHeight);
    oFrame.style.width = oBody.scrollWidth + (oBody.offsetWidth - oBody.clientWidth);
  }

  function window_onresize() {
    ifraRecordingEditor_onresize();
    window_onscroll();
  }

  addEvent(window, 'load', window_onload);
  addEvent(window, 'resize', window_onresize);
  addEvent(getElement("ifraRecordingEditor"), 'resize', ifraRecordingEditor_onresize);

  addEvent(getElement('<%=txtReceiptNumber.ClientID%>'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('<%=txtRequestedBy.ClientID%>'), 'keypress', upperCaseKeyFilter); 
  addEvent(getElement('<%=txtDocumentNumber.ClientID%>'), 'keypress', upperCaseKeyFilter); 

  /* ]]> */
  </script>
</html>