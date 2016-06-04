<%@ Page Language="C#" EnableViewState="true"  EnableSessionState="true" MasterPageFile="~/workplace/dashboard.master" AutoEventWireup="true" Inherits="Empiria.Web.UI.Workflow.TasksDashboard" Codebehind="tasks.dashboard.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<asp:Content ID="dashboardItem" ContentPlaceHolderID="dashboardItemPlaceHolder" runat="Server" EnableViewState="true">
<table id="tblDashboardMenu" class="tabStrip" style='display:<%=base.ShowTabStripMenu ? "inline" : "none"%>'>
  <tr>
    <td id="tabStripItem_0" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 0);" title="">Tareas pendientes</td>
    <td id="tabStripItem_1" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 1);" title="">Trabajos en proceso</td>
    <td id="tabStripItem_2" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 2);" title="">Tareas efectuadas</td>
    <td id="tabStripItem_3" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 3);" title="">Tareas descartadas</td>
    <td id="tabStripItem_4" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="sendPageCommand('setInbox', 4);" title="">Todas las tareas</td>        
    <td>&nbsp; &nbsp;</td>
    <td><input id="currentTabStripItem" name="currentTabStripItem" type="hidden" /></td>
  </tr>
</table>
<div class="dashboardWorkarea">
  <table id="tblDashboardOptions" width="100%">
    <tr>
      <td nowrap="nowrap">Categor�a:</td>
      <td>
		  <select id="cboOrganization" class="selectBox" style="width:238px" runat="server" onchange="doOperation('updateUserInterface', this);">
        <option value="">( Todas las categor�as )</option>
				<option value="703">Inscripciones</option>
        <option value="704">Anotaciones preventivas</option>
        <option value="705">Actos registrales</option>        
        <option value="706">Calificaciones</option>
        <option value="707">Certificaciones</option>
        <option value="708">Devoluci�n de tr�mites</option>
        <option value="709">Otras tareas</option>        
		    </select>
      </td>
      <td nowrap="nowrap">Buscar por: </td>
			<td nowrap="nowrap">
        <select id="cboSearch" name="cboSearch" class="selectBox" style="width:130px" runat="server">
          <option value="CustomerKeywords">Todos los campos</option>
          <option value="Folio">N�mero de folio</option>
          <option value="Catastral">Clave catastral</option>
          <option value="Propietario">Propietario</option>
          <option value="Solicitante">Solicitante</option>
          <option value="Location">Ubicaci�n</option>
          <option value="Phone1|Phone2">Boleta de pago</option>
          <option value="Subject">Asunto</option>
          <option value="Content">Contenido</option>
          <option value="Emisor">Emisor</option>
        </select>
      </td>
      <td nowrap="nowrap">      
        <input id="txtSearchExpression" name="txtSearchExpression" class="textBox" onkeypress="return searchTextBoxKeyFilter(window.event);"
               type="text" tabindex="-1" maxlength="80" style="width:200px" runat="server" />
				<img src="../themes/default/buttons/search.gif" alt="" onclick="doOperation('loadData')" title="Ejecuta la b�squeda" />               
      </td>
      <td align="left">
        
      </td>
     <td width="80%">&nbsp;</td>
    </tr>
    <tr>
      <td nowrap="nowrap">Del d�a:</td>
      <td nowrap="nowrap">
        <input type="text" class="textBox" id='txtFromDate' name='txtFromDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
        <img id='imgFromDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtFromDate.ClientID%>'), getElement('imgFromDate'));" title="Despliega el calendario" alt="" />
        &nbsp;&nbsp;al d�a
        <input type="text" class="textBox" id='txtToDate' name='txtToDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
        <img id='imgToDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtToDate.ClientID%>'), getElement('imgToDate'));" title="Despliega el calendario" alt="" />
      </td>
      <td nowrap="nowrap">
        Prioridad:
      </td>
      <td nowrap="nowrap">
        <select id="cboDistributionType" name="cboDistributionType" class="selectBox" onchange="doOperation('updateUserInterface', this);" style="width:130px" runat="server">
          <option value="">( Todas )</option>
          <option value="5">Urgente</option>
          <option value="3">Alta</option>
          <option value="2">Normal</option>
        </select>
      </td>      
      <td nowrap="nowrap" colspan="3">
        <a href="javascript:doOperation('createObject')"><img src="../themes/default/buttons/go.button.png" alt=""
                 title="Imprime el reporte con la programaci�n de reparto para las unidades seleccionadas" />Crear una nueva tarea</a> &nbsp; &nbsp;
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
      case 'updateUserInterface':
        updateUserInterface(arguments[1]);
        return;
      default:
        alert('La operaci�n solicitada todav�a no ha sido definida en el programa.');
        return;
    }
  }

  function createObject() {
    alert('La operaci�n solicitada todav�a no ha sido definida en el programa.');  
    return false;
  }

  function loadData() {
    sendPageCommand("loadData");
  }
  
  function updateUserInterface(oSourceControl) {
    sendPageCommand("updateUserInterface");
  }

	/* ]]> */
	</script>
</asp:Content>
