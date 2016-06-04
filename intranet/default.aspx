<%@ Page language="c#" Inherits="Empiria.Web.UI.LogonPage" EnableViewState="false" EnableSessionState="true" Codebehind="default.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head>
  <title><%="Inicio � " + Empiria.ExecutionServer.Name + " � " + Empiria.ExecutionServer.CustomerName %></title>
  <meta http-equiv="Expires" content="-1" />
  <meta http-equiv="Pragma" content="no-cache" />
  <meta http-equiv="X-UA-Compatible" content="IE=EmulateIE7" />
  <meta name="MS.LOCALE" content="ES-MX" />
  <meta name="CATEGORY" content="home page" />
  <link rel="SHORTCUT ICON" href="favicon.ico" />
	<script type="text/javascript" src="./scripts/empiria.general.js"></script>
	<link href="./themes/default/css/logon.css" type="text/css" rel="stylesheet" />
	<base target="_blank" />
	<script type="text/javascript">
	/* <![CDATA[ */

		var gbSended = false;

		function txtPassword_onkeypress(e) {
			var oEvent = getEvent(e);
		  var keycode = oEvent.which ? oEvent.which : oEvent.keyCode;
		  
		  if ((keycode == 13) && (getElement("txtPassword").value != '')) {
				doLogin();
				cancelEvent(oEvent);
		  }
		}

		function txtUserId_onkeypress(e) {
			var oEvent = getEvent(e);
		  var keycode = oEvent.which ? oEvent.which : oEvent.keyCode;
		  
		  if ((keycode == 13) && (getElement("txtUserId").value != '')) {
				getElement("txtPassword").focus();
				cancelEvent(oEvent);
		  }
		}

		function txtAccessCode_onkeypress(e) {
			var oEvent = getEvent(e);			
		  var keycode = oEvent.which ? oEvent.which : oEvent.keyCode;
		  
		  if ((keycode == 13) && (getElement("txtAccessCode").value != '')) {
				doLogin();
				cancelEvent(oEvent);
		  }
		}
		
		function validate() {
			if (getElement("txtUserId").value == '') {
				alert("Para ingresar a este sitio se requiere proporcionar el identificador de acceso.");
				getElement("txtUserId").focus();
				return false;
			}
			if (getElement("txtPassword").value == '') {
				alert("Para ingresar a este sitio se requiere proporcionar la contrase�a de acceso.");
				getElement("txtPassword").focus();
				return false;
			}
			if (getElement("txtAccessCode").value == '') {
				alert("Para ingresar a este sitio se requiere proporcionar el valor ubicado en la\nposici�n A9K de la tarjeta de acceso personal.");
				getElement("txtAccessCode").focus();
				return false;
			}
			return true;
		}

		function doLogin() {
			if (gbSended) {
				return;
			}
			document.body.style.cursor = 'wait';
			if (validate()) {
				gbSended = true;
				document.forms[0].submit();
			} else {
				document.body.style.cursor = 'default';
			}
		}

		function window_onload() {
			if (window.parent.frames.length != 0) {
				window.open("../default.aspx", "_top", null, true);
			}
			<% if (Controller.Exception.Length != 0) { %>
				alert("<%=Controller.Exception%>");
		  <% } %>
			if (getElement("txtUserId").value == "") {
			  getElement("txtUserId").focus();
			} else {
			  getElement("txtPassword").focus();
			}
			<%=clientScript%>
			<%=GetDevelopmentCode()%>
			addEvent(getElement("txtUserId"), 'keypress', txtUserId_onkeypress);
			addEvent(getElement("txtPassword"), 'keypress', txtPassword_onkeypress);
		}
		addEvent(window, 'load', window_onload);

	/* ]]> */
	</script>
</head>
<body>
	<form id="frmEditor" method="post" target="_self" runat="server">
    <div id="divMainBanner"><img src="./themes/default/customer/pleca-roja.png" style="cursor: auto;" width="672px" alt="" title="" /></div>
		<div id="divMain">     
			<div id="divLeftColumn">
			  <br />
			  <img align="middle" class="decoratorImage" src="./themes/default/customer/customer.full.logo.png" alt="" height="76px" style='margin-left:26px' />
			  <br /><br /><br /><br /><br /><br /><br /><br />
				<ul style="margin-left:12px;">
				  <li><a href="<%=Empiria.ExecutionServer.CustomerUrl%>">Gobierno del Estado de Zacatecas</a></li>
				  <li><a href="http://www.inegi.org.mx/inegi/default.aspx?s=inegi&amp;e=32">Instituto Nacional de Estad�stica y Geograf�a (INEGI)</a></li>				  
				  <li><a href="http://www.notariadomexicano.org.mx/">Asociaci�n Nacional del Notariado Mexicano</a></li>				  
					<li><a href="http://www.banxico.org.mx/PortalesEspecializados/tiposCambio/TiposCambio.html">Informaci�n financiera</a></li>
					<li><a href="http://www.precisa.gob.mx/www.php?categoria=180">Peri�dicos y revistas</a></li>
					<li><a href="http://smn.cna.gob.mx/">Consultar el estado del tiempo</a></li>
					<li><a href="http://www.google.com.mx/">B�squeda en Google</a></li>
				</ul>
			</div>
			<div id="divRightColumn">
				<div>
					<br />
					<div class="title"><%=Empiria.ExecutionServer.Name%></div>
					<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
					<strong>Acceso al sitio:</strong>
					<br /><br />
						Para ingresar a este sitio se requiere el nombre de usuario, la contrase�a de
						acceso y el valor de la posici�n D5K de la tarjeta de acceso personal:<br />&nbsp;
					<div class="formRow">
						<span class="formLabel">Usuario:</span>
						<span class="formControl"><input id="txtUserId" type="text" maxlength="32" size="24" name="txtUserId" runat="server" /></span>
					</div>
					<div class="formRow">
						<span class="formLabel">Contrase�a:</span>
						<span class="formControl"><input id="txtPassword" type="password" maxlength="32" size="24" name="txtPassword" runat="server" /></span>
					</div>
          <div class="formRow">
						<span class="formLabel">Tarjeta de acceso:<br />(Posici�n D5K) </span>
						<span class="formControl"><input id="txtAccessCode" type="text" maxlength="6" size="24" name="txtAccessCode" runat="server" /></span>
					</div>
					<div class="formRow">
						<span class="formButton">
							<a href="javascript:doLogin();" target="_self">							
							<img id="loginBtn" src="./themes/default/buttons/go.button.png" alt="" />Ingresar al sitio</a>
						</span>            
					</div>
				</div>
				<div class="divOptionsMenu">
					<cite>Departamento de Inform�tica<br />
					<b>Direcci�n de Catastro y Registro P�blico</b></cite>
				</div>
			</div> <!-- /div divRightColumn !-->		
			<div id="divFooter">
				<span class="leftItem"><a href="<%=Empiria.ProductInformation.CopyrightUrl%>"><%=Empiria.ProductInformation.Name%></a></span>
				<span class="rightItem"><a href="<%=Empiria.ProductInformation.CopyrightUrl%>"><%=Empiria.ProductInformation.Copyright%></a></span>
        <br />
			</div>
		</div> <!-- /div divMain !-->
	</form>
</body>
</html>
