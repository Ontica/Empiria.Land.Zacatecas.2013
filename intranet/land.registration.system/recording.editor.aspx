<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Web.UI.LRS.RecordingEditor" Codebehind="recording.editor.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<%@ Register tagprefix="empiriaControl" tagname="RecordingActAttributesEditorControl" src="../land.registration.system.controls/recording.act.attributes.editor.control.ascx" %>
<%@ Register tagprefix="empiriaControl" tagname="LRSRecordingPartyEditorControl" src="../land.registration.system.controls/recording.party.editor.control.ascx" %>
<%@ Register tagprefix="empiriaControl" tagname="LRSRecordingPartyViewerControl" src="../land.registration.system.controls/recording.party.viewer.control.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head runat="server">
<title></title>
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
<link href="../themes/default/css/secondary.master.page.css" type="text/css" rel="stylesheet" />
<link href="../themes/default/css/editor.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="../scripts/empiria.ajax.js"></script>
<script type="text/javascript" src="../scripts/empiria.general.js"></script>
<script type="text/javascript" src="../scripts/empiria.secondary.master.page.js"></script>
<script type="text/javascript" src="../scripts/empiria.validation.js"></script>
<script type="text/javascript" src="../scripts/empiria.calendar.js"></script>	
</head>
<body style="background-color:#fafafa; top:0px; margin:0px; margin-top:-14px; margin-left:-6px;">
<form name="aspnetForm" method="post" id="aspnetForm" runat="server">
<div id="divContent">
<table id="tabStripItemView_0" style="display:inline;">
  <tr>
    <td class="subTitle">Documento a inscribir</td>
  </tr>
  <tr id="divDocumentData">
    <td>
      Categoría del documento:
      <select id="cboRecordingType" name="cboRecordingType" class="selectBox" style="width:136px" title="" onchange="return updateUserInterface(this);" runat="server">
        <option value="">( Seleccionar )</option>
        <option value="2410" title="oNotaryRecording">Escritura pública</option>
        <option value="2411" title="oTitleRecording">Título de propiedad</option>
        <option value="2412" title="oJudicialRecording">Orden/Resolución</option>
        <option value="2413" title="oPrivateRecording">Contrato</option>
        <option value="2409" title="">No determinado</option>
      </select>
      &nbsp;
      Núm de hojas <b>del instrumento</b>:
      <select id="cboSheetsCount" name="cboSheetsCount" class="selectBox" style="width:46px" title="" onchange="return updateUserInterface(this);" runat="server">
        <option value="">( ? )</option>
        <option value="1">01</option><option value="2">02</option><option value="3">03</option><option value="4">04</option><option value="5">05</option>
        <option value="6">06</option><option value="7">07</option><option value="8">08</option><option value="9">09</option><option value="10">10</option>
        <option value="11">11</option><option value="12">12</option><option value="13">13</option><option value="14">14</option><option value="15">15</option>
        <option value="16">16</option><option value="17">17</option><option value="18">18</option><option value="19">19</option><option value="20">20</option>
        <option value="21">21</option><option value="22">22</option><option value="23">23</option><option value="24">24</option><option value="25">25</option>
        <option value="26">26</option><option value="27">27</option><option value="28">28</option><option value="29">29</option><option value="30">30</option>
        <option value="31">31</option><option value="32">32</option><option value="33">33</option><option value="34">34</option><option value="35">35</option>
        <option value="36">36</option><option value="37">37</option><option value="38">38</option><option value="39">39</option><option value="40">40</option>
        <option value="41">41</option><option value="42">42</option><option value="43">43</option><option value="44">44</option><option value="45">45</option>
        <option value="46">46</option><option value="47">47</option><option value="48">48</option><option value="49">49</option><option value="50">50</option>
        <option value="51">51</option><option value="52">52</option><option value="53">53</option><option value="54">54</option><option value="55">55</option>
        <option value="56">56</option><option value="57">57</option><option value="58">58</option><option value="59">59</option><option value="60">60</option>
        <option value="61">61</option><option value="62">62</option><option value="63">63</option><option value="64">64</option><option value="65">65</option>
        <option value="66">66</option><option value="67">67</option><option value="68">68</option><option value="69">69</option><option value="70">70</option>
      </select>
      &nbsp;
      Margen sello:
      <select id="cboSealPosition" name="cboSealPosition" class="selectBox" style="width:52px" title="" onchange="return updateUserInterface(this);" runat="server">
        <option value="">( cms )</option>
        <option value="5.0">5.0</option>
        <option value="10.0">10.0</option>
        <option value="15.0">15.0</option>
        <option value="17.5">17.5</option>
        <option value="20.0">20.0</option>
        <option value="21.0">21.0</option>
        <option value="21.0">22.0</option>
      </select>
      <b style="font-size:10pt"><%=transaction.Document.DocumentKey%></b>
      <br />
    <span id="spanRecordingDocumentEditor" runat="server"></span>
      <table class="editionTable">
        <tr>
          <td>Observaciones:<br /><br /></td>
          <td colspan="2" class="lastCell">
            <textarea id="txtObservations" name="txtObservations" class="textArea" style="width:558px" cols="320" rows="2" runat="server"></textarea>
          </td>
        </tr>
        <tr id="rowEditButtons" style="display:inline">
          <td>&nbsp;</td>
          <td class="lastCell" colspan="2">
            <input id='btnSaveRecording' type="button" value="Guardar los cambios" class="button" style="width:112px;height:28px" onclick='doOperation("saveDocument")' title='Guarda el documento' />
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            <input id='cmdPrintRecordingCover' type="button" value="Imprimir carátula" class="button" style="width:112px;height:28px;top:8px" onclick='doOperation("doPrintRecordingCover")' title='Imprimir la carátula' />
            &nbsp; &nbsp;
            <input id='cmdPrintFinalSeal' type="button" value="Imprimir sello interesado" class="button" style="width:132px;height:28px;top:8px" onclick='doOperation("viewGlobalRecordingSeal")' title='Imprime el sello que va en la escritura que se entrega al interesado' />
          </td>
          <td >
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <!--
  <tr>
    <td class="subTitle">Actos jurídicos contenidos en el documento</td>
  </tr>
  !-->
  <tr>
    <td class="subTitle">Registro del documento en libros</td>
  </tr>
  <tr>
    <td>
      <div style="overflow:auto;width:90%;">
        <table class="details" style="width:100%">
          <tr class="detailsHeader">
            <td style='white-space:nowrap;'>&nbsp;</td>
            <td>Número</td>
            <td>Fecha</td>
            <td>Distrito</td>
            <td>Sección</td>
            <td>Volumen</td>
            <td>Inscripción</td>
            <td>Registró</td>
            <td>&nbsp;</td>
          </tr>
          <%=GetDocumentRecordings()%>
        </table>
          <div id="divRecordingCreation" style="vertical-align:middle; text-align:right;margin-top:4pt;">
          Registrar en:
          <select id="cboRecordingOffice" name="cboRecordingOffice" class="selectBox" style="width:136px" title="" onchange="return updateUserInterface(this);" runat="server">
            <option value="101">Zacatecas</option>
          </select>
              &nbsp;&nbsp;&nbsp;
          Sección/Libro:
          <select id="cboRecordingSection" name="cboRecordingSection" class="selectBox" style="width:192px" title="" onchange="return updateUserInterface(this);" runat="server">
            <option value="">( Seleccionar )</option>
            <option value="1071">Libro Primero Sección Primera</option>
            <option value="1072">Libro Segundo Sección Primera</option>
            <option value="1073">Libro Tercero Sección Primera</option>
            <option value="1074">Libro Cuarto Sección Primera</option>
            <option value="1075">Libro Quinto Sección Primera</option>
            <option value="1076">Sección Segunda</option>
            <option value="1077">Sección Tercera</option>
            <option value="1078">Sección Cuarta</option>
            <option value="1079">Sección Quinta</option>
            <option value="1080">Libro Tercero Sección Sexta</option>
            </select>
            <input id='cmdDoBookRecording' type="button" value="Registrar" class="button" style="width:82px;height:28px;" onclick='doOperation("doBookRecording")' title='Registrar en libros' />
        </div>
      </div>
    </td>
  </tr>
  <tr>
    <td class="subTitle"><br />Digitalización de documentos</td>
  </tr>
  <tr>
    <td>
      <div style="overflow:auto;width:90%;">
        <table class="details" style="width:100%">
          <tr class="detailsHeader">
            <td style='white-space:nowrap;'>&nbsp;</td>
            <td>Contenido</td>
            <td>Imágenes</td>
            <td>Archivo</td>
            <td>Actualizó</td>
            <td>Fecha</td>
            <td>&nbsp;</td>
          </tr>
          <tr class="detailsItem"><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td><td>&nbsp;</td></tr>
        </table>
      </div>
    </td>
  </tr>
</table>
</div>
</form>
<iframe id="ifraCalendar" style="z-index:99;left:0px;visibility:hidden;position:relative;top:0px" 
    marginheight="0" marginwidth="0" frameborder="0" scrolling="no" src="../user.controls/calendar.aspx" width="100%">
</iframe>
</body>
<script type="text/javascript">

  function doOperation(command) {
    var success = false;

    if (gbSended) {
      return;
    }
    switch (command) {
      case 'saveDocument':
        return saveDocument();
      case 'doBookRecording':
        return doBookRecording();
      case 'deleteBookRecording':
        return deleteBookRecording(arguments[1]);
      case 'viewRecordingSeal':
        viewRecordingSeal(arguments[1]);
        return;
      case 'viewGlobalRecordingSeal':
        viewGlobalRecordingSeal();
        return;
      case 'closeWindow':
        window.parent.execScript("doOperation('refreshRecording')");
        return;
      default:
        alert("La operación '" + command + "' no ha sido definida en el programa.");
        return;
    }
    if (success) {
      sendPageCommand(command);
      gbSended = true;
    }
  }

  function doBookRecording() {
    <% if (transaction.IsEmptyInstance) { %>
    alert("Este control no está ligado a un trámite válido.");
    return;
    <% } %>
    <% if (!IsReadyForEdition()) { %>
    alert("No es posible inscribir en libros debido a que el trámite no está en un estado válido para ello, o bien, no cuenta con los permisos necesarios para efectuar esta operación.");
    return false;
    <% } %>
    <% if (transaction.Document.IsEmptyInstance) { %>
    alert("Primero requiero se ingresen los datos de la escritura o documento que se va a inscribir.");
    return false;
    <% } %>
    if (getElement('cboRecordingOffice').value.length == 0) {
      alert("Requiero se proporcione el distrito donde se inscribirá el documento.");
      return false;
    }
    if (getElement('cboRecordingSection').value.length == 0) {
      alert("Necesito conocer la sección donde se inscribirá el documento.");
      return false;
    }
    sendPageCommand('doBookRecording');
    return true;
  }

  function saveDocument() {
    <% if (transaction.IsEmptyInstance) { %>
    alert("Este control no está ligado a un trámite válido.");
    return;
    <% } %>
    <% if (!IsReadyForEdition()) { %>
    alert("No es posible modificar este documento debido a que no está en un estado válido para ello, o bien, no cuenta con los permisos necesarios para efectuar esta operación.");
    return false;
    <% } %>
    if (getElement('cboRecordingType').value.length == 0) {
      alert("Requiero se proporcione el tipo de documento.");
      return false;
    }
    if (getElement('cboSheetsCount').value.length == 0) {
      alert("Necesito conocer el número de hojas que tiene el documento, incluyendo la hoja donde irán los sellos.");
      return false;
    }
    if (getElement('cboSealPosition').value.length == 0) {
      alert("Necesito conocer el margen superior donde se colocará el sello.");
      return false;
    }
    if (!<%=oRecordingDocumentEditor.ClientID%>_validate('<%=transaction.PresentationTime.ToString("dd/MMM/yyyy")%>')) {
      return false;
    }
    sendPageCommand('saveDocument');
    return true;
  }

  function deleteBookRecording(recordingId) {
    <% if (!IsReadyForEdition()) { %>
    alert("No es posible eliminar la partida debido a que el documento no está abierto para registro en libros, o no cuenta con los permisos necesarios para efectuar esta operación.");
    return false;
    <% } %>
    if (confirm("¿Elimino el registro de la partida seleccionada?")) {
      sendPageCommand('deleteBookRecording', 'id=' + recordingId);
      return true;
    }
  }

  function viewGlobalRecordingSeal() {
    <% if (transaction.IsEmptyInstance || transaction.Document.IsEmptyInstance) { %>
    alert("Primero requiero se ingresen los datos de la escritura o documento que se va a inscribir.");
    return;
    <% } %>
    var url = "../land.registration.system/recording.seal.aspx?transactionId=<%=transaction.Id%>&id=-1";
    createNewWindow(url);
  }

  function viewRecordingSeal(recordingId) {
    var url = "../land.registration.system/recording.seal.aspx?transactionId=<%=transaction.Id%>&id=" + recordingId;

    createNewWindow(url);
  }

  function updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement("cboRecordingType")) {
      <%=oRecordingDocumentEditor.ClientID%>_updateUserInterface(getComboSelectedOption("cboRecordingType").title);
    }
  }

  function window_onload() {
    <%=base.OnLoadScript%>
    <% if (!IsReadyForEdition()) { %>
    protectRecordingEditor(true);
    <% } %>
    getElement("cmdPrintRecordingCover").disabled = true;
    getElement("cmdPrintFinalSeal").disabled = true;
    <% if (IsReadyForPrintRecordingCover()) { %>
    getElement("cmdPrintRecordingCover").disabled = false;
    <% } %>
    <% if (IsReadyForPrintFinalSeal()) { %>
    getElement("cmdPrintFinalSeal").disabled = false;
    <% } %>
  }

  function protectRecordingEditor(disabledFlag) {
    <%=oRecordingDocumentEditor.ClientID%>_disabledControl(disabledFlag);
    disableControls(getElement("divDocumentData"), disabledFlag);
    getElement("divRecordingCreation").style.display = disabledFlag ? 'none' : 'inline';
    //disableControls(getElement("divRecordingCreation"), disabledFlag);
  }

  addEvent(window, 'load', window_onload);
  
  </script>
</html>