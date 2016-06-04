<%@ Page Language="C#" EnableViewState="true"  EnableSessionState="true" MasterPageFile="~/workplace/dashboard.master" AutoEventWireup="true" Inherits="Empiria.Web.UI.LRS.ProcessControlDashboard" Codebehind="process.control.dashboard.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<asp:Content ID="dashboardItem" ContentPlaceHolderID="dashboardItemPlaceHolder" runat="Server" EnableViewState="true">
<table id="tblDashboardMenu" class="tabStrip" style='display:<%=base.ShowTabStripMenu ? "inline" : "none"%>'>
  <tr>
    <td id="tabStripItem_0" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 0);" title="">Mis tr�mites pendientes</td>
    <td id="tabStripItem_1" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 1);" title="">Documentos por entregar</td>
    <td id="tabStripItem_2" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 2);" title="">Mi trabajo realizado</td>
    <td id="tabStripItem_3" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 3);" title="">Recibir documentos</td> 
    <td id="tabStripItem_4"  style='display:<%=User.CanExecute("LRSTransaction.DeliveryDesk") ? "inline" : "none"%>' class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 4);" title="">Ventanilla de entregas</td>
    <td id="tabStripItem_5" style='display:<%=User.CanExecute("LRSTransaction.ControlDesk") ? "inline" : "none"%>' onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 5);" title="">Mesa de control</td>
    <td id="tabStripItem_6" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 6);" title="">Buscar tr�mites</td>    
    <td>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
    <td><input id="currentTabStripItem" name="currentTabStripItem" type="hidden" /></td>
  </tr>
</table>
<div class="dashboardWorkarea">
  <table id="tblDashboardOptions" width="100%">
    <tr>
      <td nowrap="nowrap">Tr�mite:</td>
      <td nowrap="nowrap">
        <select id="cboProcessType" class="selectBox" style="width:203px" runat="server" onchange="doOperation('updateUserInterface', this);">
          <option value="">( Todos los tr�mites )</option>
          <option value="700">Inscripci�n Propiedad</option>
          <option value="701">Certificados y copias</option>
          <option value="702">Tr�mite Comercio</option>
          <option value="703">Tr�mite Catastro</option>
          <option value="704">Correspondencia</option>
        </select>
        <span style="display:<%=base.SelectedTabStrip != 5 ? "inline" : "none" %>">
          <a href="javascript:doOperation('createLRSTransaction')"><img src="../themes/default/buttons/go.button.png" alt=""
           title="Registra un nuevo tr�mite ante la Oficina del Registro P�blico de la Propiedad" />Registrar nuevo tr�mite</a>
        </span>
        <span style="display:<%=base.SelectedTabStrip == 5 ? "inline" : "none" %>">
          <select id="cboResponsible" class="selectBox" style="width:168px" runat="server" onchange="doOperation('updateUserInterface', this);">
            <option value="">( Todos los responsables )</option>
          </select>
        </span>
      </td>
      <td nowrap="nowrap">Buscar:</td>
      <td nowrap="nowrap">
        <select id="cboSearch" name="cboSearch" class="selectBox" style="width:130px" runat="server">
          <option value="">Todos los campos</option>
          <option value="TransactionKey">N�mero de tr�mite</option>
          <option value="DocumentKey">N�mero de documento</option>
          <option value="ReceiptNumber">N�mero de boleta</option>
          <option value="DocumentNumber">Instrumento</option>
          <option value="ControlNumber">N�mero de control</option>
        </select>
      </td>
      <td nowrap="nowrap">
        <input id="txtSearchExpression" name="txtSearchExpression" class="textBox" onkeypress="return searchTextBoxKeyFilter(window.event);"
               type="text" tabindex="-1" maxlength="80" style="width:204px" runat="server" />
      </td>
      <td align="left" nowrap="nowrap">
        <img src="../themes/default/buttons/search.gif" alt="" onclick="doOperation('loadData')" title="Ejecuta la b�squeda" />
        &nbsp; &nbsp; &nbsp; &nbsp;
        <a href="javascript:doOperation('removeFilters')">Quitar los filtros</a>
        <% if (base.User.Id == -3) { %>
          &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <a href="javascript:doOperation('updateTrack')">UT</a>
        <% } %>
      </td>
     <td width="80%">&nbsp;</td>
    </tr>
    <tr>
      <td nowrap="nowrap">Fecha:</td>
      <td nowrap="nowrap">
        <select id="cboDate" name="cboDate" class="selectBox" onchange="doOperation('updateUserInterface', this);" style="width:98px" runat="server">
          <option value="">No filtrar</option>
          <option value="PostingTime">Precalificaci�n</option>
          <option value="PresentationTime">Presentaci�n</option>
          <option value="ElaborationTime">Elaboraci�n</option>
          <option value="SignTime">Firma</option>
          <option value="ClosingTime">Cierre</option>
          <option value="LastDeliveryTime">Entrega</option>
        </select>
        Del:
        <input type="text" class="textBox" id='txtFromDate' name='txtFromDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
        <img id='imgFromDate' style="margin-left:-8px" src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtFromDate.ClientID%>'), getElement('imgFromDate'));" title="Despliega el calendario" alt="" />
        al:
        <input type="text" class="textBox" id='txtToDate' name='txtToDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
        <img id='imgToDate' style="margin-left:-8px" src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtToDate.ClientID%>'), getElement('imgToDate'));" title="Despliega el calendario" alt="" />
          <a href="javascript:doOperation('setTodayDate')">Hoy</a>
      </td>
      <td nowrap="nowrap">
        Distrito:
      </td>
      <td nowrap="nowrap" colspan="4">
        <select id="cboRecorderOffice" name="cboRecorderOffice" class="selectBox" onchange="doOperation('updateUserInterface', this);" style="width:130px" runat="server">
          <option value="">( Todos )</option>
          <option value="101">Zacatecas</option>
          <option value="102">Fresnillo</option>
          <option value="103">Jerez</option>
          <option value="104">R�o Grande</option>
          <option value="105">Sombrerete</option>
          <option value="106">Tlaltenango</option>
          <option value="107">Calera</option>
          <option value="108">Concepci�n del Oro</option>
          <option value="109">Jalpa</option>
          <option value="110">Juchipila</option>
          <option value="111">Loreto</option>
          <option value="112">Miguel Auza</option>
          <option value="113">Nochistl�n</option>
          <option value="114">Ojocaliente</option>
          <option value="115">Pinos</option>
          <option value="116">Te�l de Gonz�lez Ortega</option>
          <option value="117">Valpara�so</option>
          <option value="118">Villanueva</option>
        </select>
        <span style="display:<%=base.SelectedTabStrip == 3 ? "inline" : "none" %>">
         Origen:
         <select id="cboFrom" name="cboFrom" class="selectBox" onchange="doOperation('updateUserInterface', this);" style="width:200px" runat="server">
          <option value="">( �Qui�n le est� entregando? )</option>
        </select>
        </span>
        <span style="display:<%=base.SelectedTabStrip != 3 ? "inline" : "none" %>">
         Estado:
         <select id="cboStatus" name="cboStatus" class="selectBox" onchange="doOperation('updateUserInterface', this);" style="width:170px" runat="server">
          <option value="(TransactionStatus <> 'X')">( Todos los no eliminados )</option>
          <option value="(TrackStatus <> 'C' AND TransactionStatus NOT IN('X','Y','D','L','H','Q','C'))">Tr�mites en proceso</option>
          <option value="(TrackStatus = 'C' AND TransactionStatus <> 'X')">Tr�mites concluidos</option>
          <option value="(LastReentryTime <> '2078-12-31' AND TrackStatus <> 'C' AND TransactionStatus <> 'X')">Reingresos en proceso</option>
          <option value="">- - - - - - - - - - - - - - - - - - - - -</option>
          <option value="(TransactionStatus = 'Y')">Precalificaci�n</option>
          <option value="(TransactionStatus = 'R')">Tr�mite recibido</option>
          <option value="(TransactionStatus = 'K')">En mesa de control</option>
          <option value="(TransactionStatus = 'F')">En calificaci�n</option>
          <option value="(TransactionStatus = 'G')">Registro en libros</option>
          <option value="(TransactionStatus = 'E')">Elaboraci�n</option>
          <option value="(TransactionStatus = 'V')">Revisi�n</option>
          <option value="(TransactionStatus = 'S')">En firma</option>
          <option value="(TransactionStatus = 'A')">Digitalizaci�n y resguardo</option>
          <option value="(TransactionStatus IN ('D','L'))">Por entregar o devolver</option>
          <option value="(TransactionStatus IN ('C','Q'))">Entregados y devueltos al interesado</option>
          <option value="(TransactionStatus = 'H')">Tr�mite archivado</option>
          <option value="(TransactionStatus = 'X')">Tr�mite eliminado</option>
        </select>
        </span>
        Tiempo:
        <select id="cboElapsedTime" class="selectBox" style="width:90px" runat="server" onchange="doOperation('updateUserInterface', this);">
          <option value=''>(Todos)</option>
          <option value='(WorkingTime <= 86400*3)'><= 3 d�as</option>
          <option value='(WorkingTime >= 86400*3)'>>= 3 d�as</option>
          <option value='(WorkingTime <= 86400*5)'><= 5 d�as</option>
          <option value='(WorkingTime >= 86400*5)'>>= 5 d�as</option>
          <option value='(WorkingTime <= 86400*10)'><= 10 d�as</option>
          <option value='(WorkingTime >= 86400*10)'>>= 10 d�as</option>
          <option value='(WorkingTime <= 86400*15)'><= 15 d�as</option>
          <option value='(WorkingTime >= 86400*15)'>>= 15 d�as</option>
          <option value='(WorkingTime <= 86400*20)'><= 20 d�as</option>
          <option value='(WorkingTime >= 86400*20)'>>= 20 d�as</option>
          <option value='(WorkingTime >= 86400*25)'>>= 25 d�as</option>
          <option value='(WorkingTime >= 86400*30)'>>= 30 d�as</option>
          <option value='(WorkingTime >= 86400*40)'>>= 40 d�as</option>
          <option value='(WorkingTime >= 86400*50)'>>= 50 d�as</option>
        </select>
      </td>
    </tr>
  </table>
  <div id="divObjectExplorer" class="dataTableContainer">
    <table>
      <asp:Repeater id="itemsRepeater" runat="server" EnableViewState="False"></asp:Repeater>
    </table>
  </div>
  <%=base.NavigationBarContent()%>
</div>
<script type="text/javascript">
  /* <![CDATA[ */

  function doOperation(operationName) {
    switch (operationName) {
      case 'loadData':
        loadData();
        return;
      case 'createObject':
        createObject();
        return;
      case 'createLRSTransaction':
        createLRSTransaction();
        return;
      case 'receiveLRSTransaction':
        receiveLRSTransaction();
        return;
      case 'takeLRSTransaction':
        takeLRSTransaction(arguments[1]);
        return;
      case 'returnDocumentToMe':
        returnDocumentToMe(arguments[1]);
        return;
      case 'printOnSignReport':
        printOnSignReport();
        return;
      case 'setTodayDate':
        setTodayDate();
        return;
      case 'receiveDocuments':
        receiveLRSDocuments(arguments[1]);
        break;
      case 'editTransaction':
        showTransactionEditor(arguments[1]);
        return;
      case 'removeFilters':
        removeFilters();
        return;
      case 'updateTrack':
        updateTrack();
        return;
      case 'updateUserInterface':
        updateUserInterface(arguments[1]);
        return;
      default:
        alert('La operaci�n solicitada todav�a no ha sido definida en el programa.');
        return;
    }
  }

  function updateTrack() {
    if (confirm("Actualizo el Track de eventos???")) {
      sendPageCommand("updateTrack");
    }
  }

  function createLRSTransaction() {
    if (getElement('<%=cboProcessType.ClientID%>').value.length == 0) {
      alert("Requiero se seleccione de la lista el tipo de tr�mite que se desea registrar.");
      return;
    }
    var source = "transaction.editor.aspx?";
    source += "id=0&typeId=" + getElement('<%=cboProcessType.ClientID%>').value;

    createNewWindow(source);
  }

  function printOnSignReport() {
    var source = "transaction.report.aspx";

    createNewWindow(source);
  }

  function receiveLRSTransaction(transactionId) {
    var sMsg = "Recepci�n del tr�mite por parte del interesado\n\n";

    sMsg += "Tr�mite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
    sMsg += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
    sMsg += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";

    sMsg += "�Est� recibiendo los documentos de este tr�mite por parte del interesado?";

    if (confirm(sMsg)) {
      var qs = "id=" + transactionId;
      qs += "|notes=" + getElement("txtNotes" + transactionId).value;
      sendPageCommand("receiveLRSTransaction", qs);
    }
  }

  function setTodayDate() {
    getElement('<%=txtFromDate.ClientID%>').value = '<%=DateTime.Today.ToString("dd/MMM/yyyy")%>';
    getElement('<%=txtToDate.ClientID%>').value = '<%=DateTime.Today.ToString("dd/MMM/yyyy")%>';
  }

  function takeLRSTransaction(transactionId) {
    var nextStatus = getInnerText('ancNextStatusID' + transactionId);

    if (nextStatus == 'S') {
    <% if (!User.CanExecute("LRSTransaction.DocumentSigner")) { %>
      alert("No tengo registrados los permisos necesarios para entregarle este documento.\n\nEl documento est� marcado como 'Recibir para firma'.");
      return;
    <% } %>
    }
    if (nextStatus == 'K') {
      <% if (!User.CanExecute("LRSTransaction.ControlDesk")) { %>
        alert("No tengo registrados los permisos necesarios para entregarle este documento.\n\nEl documento est� marcado para recibirlo en mesa de control.\n\nS�lo los responsables de la mesa de control pueden tomarlo.");
        return;
      <% } %>
    }
    if (nextStatus == 'A') {
    <% if (!User.CanExecute("LRSTransaction.DocumentSafeguard")) { %>
      alert("No tengo registrados los permisos necesarios para entregarle este documento.\n\nEl documento est� marcado para recibirlo en la mesa de digitalizaci�n y resguardo'.");
      return;
      <% } %>
    }
    if (nextStatus == 'D' || nextStatus == 'L') {
      <% if (!User.CanExecute("LRSTransaction.DeliveryDesk")) { %>
        alert("No tengo registrados los permisos necesarios para entregarle este documento.\n\nEl documento ya est� listo para entregarlo (o devolverlo) al interesado.\n\nS�lo los responsables de ventanilla de entregas pueden tomarlo.");
        return;
      <% } %>
    }
    if (nextStatus == 'V') {
      <% if (!User.CanExecute("LRSTransaction.QualityControl")) { %>
        alert("No tengo registrados los permisos necesarios para entregarle este documento.\n\nEste tr�mite est� listo para enviarse al �rea de revisi�n.\n\nS�lo el personal del �rea de revisi�n puede tomar este tr�mite.");
        return;
      <% } %>
    }
    if (nextStatus == 'J') {
      <% if (!User.CanExecute("LRSTransaction.Juridic")) { %>
        alert("No tengo registrados los permisos necesarios para entregarle este documento.\n\nEste tr�mite est� marcado para entregarse al �rea jur�dica.");
        return;
      <% } %>
    }
    if (nextStatus == 'R' || nextStatus == 'C' || nextStatus == 'Q') {
      alert("No tengo registrados los permisos necesarios para entregarle este documento.\n\nEste tr�mite debe procesarse utilizando otra herramienta.");
      return;
    }
    var sMsg = "Recibir documentaci�n.\n\n";

    sMsg += "Tr�mite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
    sMsg += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
    sMsg += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";

    sMsg += "Estado actual:\t" + getInnerText('ancStatus' + transactionId) + "\n";
    sMsg += "Nuevo estado:\t" + getInnerText('ancNextStatus' + transactionId) + "\n\n";
        
    sMsg += "�Est� recibiendo los documentos del tr�mite referido?";

    if (confirm(sMsg)) {
      var qs = "id=" + transactionId;
      qs += "|notes=" + getElement("txtNotes" + transactionId).value;
      sendPageCommand("takeLRSTransaction", qs);
    }
  }


  function validateNextTransactionState(transactionId, newState) {
    var ajaxURL = "../ajax/land.registration.system.data.aspx";
    ajaxURL += "?commandName=validateNextTransactionStateCmd";
    ajaxURL += "&transactionId=" + transactionId + "&newState=" + newState;

    return invokeAjaxValidator(ajaxURL);
  }

  function doTransactionOperation(transactionId) {
    var newState = getElement("cboOperation" + transactionId).value;
    if (newState == "") {
      alert("Requiero se seleccione el nuevo estado del tr�mite");
      return;
    }
    if (!validateNextTransactionState(transactionId, newState)) {
      return;
    }
    var temp = "";
    if (newState == "R") {
      return receiveLRSTransaction(transactionId);
    } else if (newState == "P") {
      temp = "Enviar este tr�mite a otra mesa de trabajo.\n\n";

      temp += "Tr�mite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
      temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
      temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
      temp += "�Preparo este tr�mite para enviarlo a otra mesa de trabajo?";
    } else if (newState == "S") {
      temp = "Enviar tr�mite a firma\n\n";

      temp += "Tr�mite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
      temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
      temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
      temp += "�El tr�mite est� listo para firma?";
    } else if (newState == "D") {
      temp = "Enviar tr�mite a mesa de entrega\n\n";
      temp += "�El tr�mite est� listo para entregarlo al interesado?";
    } else if (newState == "C") {
      temp = "Entregar el tr�mite al interesado\n\n";
      temp += "Tr�mite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
      temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
      temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
      temp += "�Se est� entregando el tr�mite al interesado?";
    } else if (newState == "L") {
      temp = "Devolver el tr�mite al interesado, ya que no procede\n\n";
      temp += "Tr�mite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
      temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
      temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
      temp += "�Se va a devolver el tr�mite al interesado?";
    } else if (newState == "H") {
      temp = "Finalizar este tr�mite\n\n";
      temp += "Tr�mite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
      temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
      temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
      temp += "�Marco este tr�mite como finalizado? (Ya no se prodr� hacerle cambios)";
    } else if (newState == "X") {
      temp = "Eliminar este tr�mite\n\n";
      temp += "Tr�mite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
      temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
      temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
      temp += "�Elimino este tr�mite en forma definitiva?";
    } else {
      temp = "Enviar este tr�mite a otra mesa de trabajo:\n\n";
      temp += "Tr�mite: \t     " + getInnerText('ancTransactionKey' + transactionId) + "\n";
      temp += "Interesado:     " + getInnerText('ancRequestedBy' + transactionId) + "\n";
      temp += "Instrumento:  " + getInnerText('ancInstrument' + transactionId) + "\n\n";
      
      temp += "�Muevo este tr�mite al estado seleccionado?";
    }
    if (confirm(temp)) {
      var qs = "id=" + transactionId;
      qs += "|state=" + newState;
      qs += "|notes=" + getElement("txtNotes" + transactionId).value;
      sendPageCommand("changeTransactionStatus", qs);
    }
  }

  function returnDocumentToMe(transactionId) {
    var sMsg = "Regresar tr�mite a mi bandeja de pendientes\n\n";
    sMsg += "�Regreso el documento a la bandeja de tr�mites pendientes?";

    if (confirm(sMsg)) {
      sendPageCommand("returnDocumentToMe", "id=" + transactionId);
    }
  }

  function showTransactionEditor(transactionId) {
    var source = "transaction.editor.aspx?";
    source += "id=" + transactionId;
    createNewWindow(source);
  }


  function loadData() {
    sendPageCommand("loadData");
  }
  
  function updateUserInterface(oSourceControl) {
    sendPageCommand("updateUserInterface");
  }

  function removeFilters() {
    getElement('<%=cboProcessType.ClientID%>').value = '';
    getElement('<%=cboDate.ClientID%>').value = '';
    getElement('<%=cboSearch.ClientID%>').value = '';
    getElement('<%=txtSearchExpression.ClientID%>').value = '';
    getElement('<%=txtFromDate.ClientID%>').value = '01/jul/2012';
    getElement('<%=txtToDate.ClientID%>').value = '<%=DateTime.Today.ToString("dd/MMM/yyyy")%>';
    getElement('<%=cboRecorderOffice.ClientID%>').value = '';
    getElement('<%=cboStatus.ClientID%>').value = '';
    getElement('<%=cboElapsedTime.ClientID%>').value = '';
    getElement('<%=cboResponsible.ClientID%>').value = '';   
  }

  /* ]]> */
  </script>
</asp:Content>
