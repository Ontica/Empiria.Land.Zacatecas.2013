<%@ Page Language="C#" EnableViewState="true" AutoEventWireup="true" Inherits="Empiria.Web.UI.LRS.RecordingBookAnalyzer" Codebehind="recording.book.analyzer.aspx.cs" %>
<%@ OutputCache Location="None" NoStore="true" %>
<%@ Register tagprefix="empiriaControl" tagname="LRSRecordingPaymentEditorControl" src="../land.registration.system.controls/recording.payment.editor.control.ascx" %>
<%@ Import Namespace="Empiria.Government.LandRegistration" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="es-mx">
<head id="Head1" runat="server">
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
<body>
<form name="aspnetForm" method="post" id="aspnetForm" runat="server">
  <div>
    <input type="hidden" name="hdnPageCommand" id="hdnPageCommand" runat="server" />
    <input type="hidden" name="hdnCurrentImagePosition" id="hdnCurrentImagePosition" runat="server" />		
  </div>
  <div id="divCanvas">
    <div id="divHeader">
      <span id="spanPageTitle" class="appTitle">
        &nbsp;
      </span>
      <span id="spanCurrentImage" class="rightItem appTitle" style="margin-right:8px">
        &nbsp;
      </span>
    </div> <!--divHeader!-->
    <div id="divBody">
      <div id="divContent">
        <table cellpadding="0" cellspacing="0">
          <tr>
            <td id="divImageViewer" valign='top' style="position:relative">
              <div id="divImageContainer" style="overflow:auto;width:520px;height:540px;top:0px;">
                <img id="imgCurrent" name="imgCurrent" src="<%=GetCurrentImagePath()%>" alt="" width="<%=GetCurrentImageWidth()%>" height="<%=GetCurrentImageHeight()%>" style="top:0px;" />
              </div>
              <table>                
                <tr>
                  <td nowrap='nowrap'>Ver:</td>
                  <td nowrap='nowrap'>
                    <select id="cboRecordingBookSelector" class="selectBox" style="width:124px" onchange="showRecordingImages(this.value);" title="" runat="server">										
                    </select>
                  </td>
                  <td nowrap='nowrap'>
                    Ir a la imagen: <input id="txtGoToImage" name="txtGoToImage" type="text" class="textBox" maxlength="4" style="width:35px;margin-right:0px" onkeypress="return integerKeyFilter(this);" runat="server" />
                  </td>
                  <td nowrap='nowrap'><img src="../themes/default/buttons/search.gif" alt="" onclick="return doOperation('gotoImage')" title="Ejecuta la b�squeda" /></td>
                  <td width='40%'>&nbsp;</td>
                  <td><img src='../themes/default/buttons/first.gif' onclick='doOperation("moveToImage", "first");' title='Muestra la primera imagen' alt='' /></td>
                  <td><img src='../themes/default/buttons/previous.gif' onclick='doOperation("moveToImage", "previous");' title='Muestra la imagen anterior' alt='' /></td>
                  <td><img src='../themes/default/buttons/next.gif' onclick='doOperation("moveToImage", "next");' title='Muestra la siguiente imagen' alt='' /></td>
                  <td><img src='../themes/default/buttons/last.gif' onclick='doOperation("moveToImage", "last");' title='Muestra la �ltima imagen' alt='' /></td>
                  <td width='10px' nowrap='nowrap'>&nbsp;</td>
                  <td nowrap='nowrap'>
                    <% if (User.CanExecute("BatchCapture.Supervisor")) { %>
                    <select id="cboImageOperation" name="cboImageOperation" class="selectBox" style="width:100px" title="" runat="server">
                      <option value="selectRecordingActOperation">(Operaci�n)</option>
                      <option value="insertEmptyImageBefore">Insertar</option>
                      <option value="deleteImage">Eliminar</option>
                      <option value="refreshImages">Reprocesar</option>
                    </select>
                    <img src='../themes/default/buttons/ellipsis.gif' onclick='doOperation(getElement("cboImageOperation").value);' title='Ejecuta la operaci�n seleccionada' alt='' />
                    <% } %>
                  </td>
                  <td width='10px' nowrap='nowrap'>&nbsp;</td>
                  <td align="right" style="width:40%" nowrap='nowrap'>
                    Zoom: 
                    <select id="cboZoomLevel" name="cboZoomLevel" class="selectBox" style="width:56px" title="" onchange="return doOperation('zoomImage')" runat="server">
                      <option value="0.50">50%</option>
                      <option value="0.75">75%</option>
                      <option value="1.00">100%</option>
                      <option value="1.25">125%</option>
                      <option value="1.50">150%</option>
                      <option value="1.75">175%</option>
                      <option value="2.00">200%</option>
                    </select>
                  </td>
                </tr>
              </table>
            </td>
            <td><img src="../themes/default/textures/pixel.gif" height="1px" width="12px" alt="" /></td>
            <td id="divDocumentViewer" valign="top" style="width:670px;">
              <table class="tabStrip">
                <tr>
                  <td id="tabStripItem_0" class="tabOn" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);"  onclick="doCommand('onClickTabStripCmd', this);" title="">Analizar inscripciones</td>
                  <td id="tabStripItem_1" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Editor de informaci�n</td>																
                  <td id="tabStripItem_2" class="tabOff" onmouseover="doCommand('onMouseOverTabStripCmd', this);" onmouseout="doCommand('onMouseOutTabStripCmd', this);" onclick="doCommand('onClickTabStripCmd', this);" title="">Inscripciones registradas</td>									
                  <td class="lastCell"><a id="top" /></td>
                </tr>
              </table>

            <table id="tabStripItemView_0" class="editionTable" style="display:inline;">
              <tr>
                <td class="subTitle">Identificaci�n, prelaci�n y derechos de inscripci�n</td>
              </tr>
              <tr>
                <td>
                  <table id='tblRecording' class="editionTable">
                  <tr>
                    <td colspan="4">Libro:
                      <input type="text" class="textBox" readonly="readonly" style="width:368px"  title="" value="<%=recordingBook.FullName%>" />
                      &nbsp;Tipo de inscripci�n:
                    </td>
                    <td>
                      <select id="cboRecordingType" name="cboRecordingType" class="selectBox" style="width:136px" title="" onchange="return updateUserInterface(this);" runat="server">
                        <option value="">( Seleccionar )</option>
                        <option value="2410" title="oNotaryRecording">Escritura p�blica</option>
                        <option value="2411" title="oTitleRecording">T�tulo de propiedad</option>
                        <option value="2412" title="oJudicialRecording">Orden/Resoluci�n</option>
                        <option value="2413" title="oPrivateRecording">Contrato</option>
                        <option value="2409" title="">No determinado</option>
                      </select>
                    </td>
                    <td class="lastCell">&nbsp;</td>
                  </tr>
                  <tr>
                    <td>N�mero de inscripci�n:</td>
                    <td>
                      <input id="txtRecordingNumber" type="text" class="textBox" style="width:35px;margin-right:0px" onkeypress="return integerKeyFilter(this);" title="" maxlength="5" runat="server" />
                      <input id="chkUseBisRecordingNumber" type="checkbox" runat="server" style="vertical-align:middle" tabindex="-1" />Bis&nbsp; &nbsp;
                      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Inscrita de la imagen:
                    </td>
                    <td>
                      <input id="txtImageStartIndex" type="text" class="textBox" style="width:40px"
                             onkeypress="return integerKeyFilter(this);" title="" maxlength="4"  runat="server" /><img src="../themes/default/buttons/select_page.gif" 
                             onclick="pickCurrentImage('txtImageStartIndex')" title="Selecciona el n�mero de imagen que se est� desplegando" alt="" />
                    </td>
                    <td>a la imagen:</td>
                    <td>
                      <input id="txtImageEndIndex" type="text" class="textBox" style="width:40px" 
                             onkeypress="return integerKeyFilter(this);" title="" maxlength="4"  runat="server" /><img src="../themes/default/buttons/select_page.gif" 
                      onclick="pickCurrentImage('txtImageEndIndex')" title="Selecciona el n�mero de imagen que se est� desplegando" alt="" />											
                    </td>
                    <td class="lastCell">&nbsp;</td>
                  </tr>            
                  <tr>
                    <td>Fecha de presentaci�n:</td>
                    <td>
                      <input id='txtPresentationDate' name='txtPresentationDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                      <img id='imgPresentationDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtPresentationDate'), getElement('imgPresentationDate'));" title="Despliega el calendario" alt="" />
                      &nbsp;&nbsp;&nbsp;Hora de presentaci�n:</td>
                    <td><input id="txtPresentationTime" name="txtPresentationTime" type="text" class="textBox" style="width:40px" maxlength="5" title="" onkeypress='return hourKeyFilter(this);' runat="server" /> Hrs</td>
                    <td>Autorizaci�n:</td>
                    <td>
                      <input id='txtAuthorizationDate' name='txtAuthorizationDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                      <img id='imgAuthorizationDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtAuthorizationDate'), getElement('imgAuthorizationDate'));" title="Despliega el calendario" alt="" />
                    </td>
                    <td class="lastCell">&nbsp;</td>
                  </tr>
                  <tr>
                    <td class="lastCell" colspan="6">
                      <empiriaControl:LRSRecordingPaymentEditorControl ID="oRecordingPaymentEditorControl" runat="server" />
                    </td>
                  </tr>
                  <tr>
                    <td>El C. Registrador: &nbsp; &nbsp;&nbsp;Lic.</td>
                    <td colspan="2">
                      <select id="cboAuthorizedBy" name="cboAuthorizedBy" class="selectBox" style="width:304px" title="" onchange="return updateUserInterface();" runat="server">
                      </select>
                    </td>
                    <td>Estado:</td>
                    <td>
                      <select id="cboStatus" name="cboStatus" class="selectBox" style="width:134px" title="" runat="server">
                      </select>
                    </td>
                    <td class="lastCell">&nbsp;</td>
                  </tr>
                  <tr id="rowNoVigentOrIlegibleButtons" style="display:none">
                    <td>&nbsp;</td>
                    <td colspan="2">
                      <input type="button" value="Analizar m�s tarde" class="button" style="width:110px" onclick='doOperation("registerAsPendingRecording")' title='Guarda la inscripci�n y la marca como pendiente para su an�lisis posterior' />
                      <img src="../themes/default/textures/pixel.gif" height="1px" width="42px" alt="" />
                      <input type="button" value="Registrar como no legible" class="button" style="width:144px" onclick='doOperation("registerAsNoLegibleRecording")' title='Guarda la inscripci�n y la marca como no legible' />									
                    </td>
                    <td colspan="2" align="right">
                      <input type="button" value="Registrar como no vigente" class="button" style="width:142px" onclick='doOperation("registerAsObsoleteRecording")' title='Guarda la inscripci�n y la marca como no vigente' />
                      &nbsp;
                    </td>
                    <td class="lastCell">&nbsp;</td>
                  </tr>
                </table>
              </td>
              </tr>
              <tr><td class="subTitle">Informaci�n general de la inscripci�n</td></tr>
              <tr>
                <td>
                  <span id="spanRecordingDocumentEditor" runat="server"></span>
                  <table class="editionTable">
                    <tr>
                      <td>Observaciones:<br /><br /></td>
                      <td colspan="2" class="lastCell">
                        <textarea id="txtObservations" name="txtObservations" class="textArea" style="width:558px" cols="320" rows="2" runat="server"></textarea>
                      </td>
                    </tr>
                    <tr id="rowEditButtons" style="display:none">
                      <td>&nbsp;</td>
                      <td colspan="2" class="lastCell">
                        <input id='btnEditRecording' type="button" value="Editar esta inscripci�n" class="button" style="width:130px" onclick='doOperation("onclick_editRecordingForEdition");' title='Guarda la inscripci�n y la marca como no legible' />
                        <img src="../themes/default/textures/pixel.gif" height="1px" width="216px" alt="" />
                        <input id='btnDeleteRecording' type="button" value="Eliminar" class="button" disabled='disabled' style="width:70px" onclick='doOperation("deleteRecording")' title='Elimina completamente esta inscripci�n y todos los actos y propiedades que contiene' />											
                        <img src="../themes/default/textures/pixel.gif" height="1px" width="16px" alt="" />
                        <input id='btnSaveRecording' type="button" value="Guardar los cambios" class="button" disabled='disabled' style="width:112px" onclick='doOperation("saveRecording")' title='Guarda la inscripci�n y la marca como no vigente' />
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr><td class="subTitle">Actos jur�dicos vigentes contenidos en la inscripci�n</td></tr>
              <tr>
                <td>
                  <table class="editionTable">
                    <tr>
                      <td colspan="8" class="lastCell">
                        <div style="overflow:auto;width:660px;">
                          <table class="details" style="width:99%">
                            <tr class="detailsHeader">
                              <td>#</td>
                              <td width="90%">Actos jur�dicos vigentes</td>
                              <td>Estado acto</td>
                              <td>Predio</td>
                              <td>Estado predio</td>
                              <td>�Qu� desea hacer?</td>
                            </tr>
                            <%=gRecordingActs%>
                          </table>
                        </div>
                      </td>
                    </tr>
                    <tr>
                      <td>Categor�a:</td>
                      <td colspan="6">
                        <select id="cboRecordingActTypeCategory" name="cboRecordingActTypeCategory" class="selectBox" style="width:272px" title="" onchange="return updateUserInterface(this);" runat='server'>
                        </select>
                        &nbsp;&nbsp; &nbsp; Sobre el predio:&nbsp;
                        <select id="cboProperty" class="selectBox" style="width:126px" title="" onchange="return updateUserInterface(this);" runat='server'>
                          <option value="0">Nuevo predio</option>
                          <option value="-1">Predio ya inscrito</option>
                        </select>
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr id="divRegisteredPropertiesSection" style="display:none">
                      <td>Libro:<br /><br />&nbsp;</td>
                      <td colspan="6">
                        <select id="cboAnotherRecorderOffice" class="selectBox" style="width:160px" title="" onchange="return updateUserInterface(this);" runat='server'>
                        </select>
                        <select id="cboAnotherRecordingBook" class="selectBox" style="width:336px" title="" onchange="return updateUserInterface(this);" runat='server'>
                        </select>
                        <br />
                        Inscripci�n:
                        <select id="cboAnotherRecording" class="selectBox" style="width:78px" title="" onchange="return updateUserInterface(this);" runat='server'>
                        </select>
                        <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la b�squeda" style="margin-left:-8px" onclick="doOperation('showAnotherRecording')" />
                        &nbsp;&nbsp;&nbsp;Predio ya inscrito:&nbsp;
                        <select id="cboAnotherProperty" class="selectBox" style="width:148px" title="" runat='server'>
                        </select>
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr>
                      <td>Acto jur�dico:</td>
                      <td colspan="5">
                        <select id="cboRecordingActType" name="cboRecordingActType" class="selectBox" style="width:420px" title="" onchange="return updateUserInterface();">
                          <option value="">( Primero seleccionar la categor�a de la inscripci�n )</option>
                        </select>
                      </td>
                      <td>
                        <input type="button" value="Agregar" class="button" style="width:68px" onclick='doOperation("registerAsIncompleteRecording")' />
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="subTitle">Anotaciones, grav�menes y otras limitaciones</td>
              </tr>
              <tr>
                <td>
                  <table class="editionTable">
                    <tr>
                     <td class="lastCell" colspan="7">
                      <div style="overflow:auto;width:660px;">
                        <table class="details" style="width:99%">
                          <tr class="detailsHeader">
                            <td>#</td>
                            <td>Predio</td>
                            <td width="30%">Anotaci�n o limitaci�n</td>
                            <td width="30%">Libro registral / Inscripci�n </td>
                            <td>Presentaci�n/Autoriz</td>
                            <td>Estado</td>
                            <td>&nbsp;</td>
                          </tr>
                          <%=gAnnotationActs%>
                          <tr class="selectedItem">
                            <td colspan="8"><a href="javascript:doOperation('showAnnotationsEditor')">Agregar una anotaci�n, un gravamen o limitaci�n</a></td>
                          </tr>
                        </table>
                      </div>
                    </td>
                    </tr>	
                    <tr id="divAnnotationEditorRow0" style="display:none">
                      <td>Categor�a:</td>
                      <td colspan="5">
                        <select id="cboAnnotationCategory" name="cboAnnotationCategory" class="selectBox" style="width:160px" title="" onchange="return updateUserInterface(this);" runat="server">
                        </select>
                      Predio:
                        <select id="cboAnnotationProperty" name="cboAnnotationProperty" class="selectBox" style="width:116px" title="" onchange="return updateUserInterface(this);" runat='server'>
                          <option value="0">Nuevo folio</option>
                        </select>
                      Documento:
                      <select id="cboAnnotationDocumentType" name="cboAnnotationDocumentType" class="selectBox" style="width:136px" title="" onchange="return updateUserInterface(this);" runat="server">
                        <option value="">( Seleccionar )</option>
                        <option value="2410" title="oNotaryRecording">Escritura p�blica</option>
                        <option value="2411" title="oTitleRecording">T�tulo de propiedad</option>
                        <option value="2412" title="oJudicialRecording">Orden de Juez</option>
                        <option value="2413" title="oPrivateRecording">Contrato privado</option>
                        <option value="2409" title="">No determinado</option>
                      </select>
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr id="divAnnotationEditorRow1" style="display:none">
                      <td>Tipo de movimiento:</td>
                      <td colspan="5">
                        <select id="cboAnnotation" name="cboAnnotation" class="selectBox" style="width:532px" title="" onchange="return updateUserInterface();">
                          <option value="">( Primero seleccionar la categor�a de la anotaci�n )</option>							
                        </select>
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr id="divAnnotationEditorRow2" style="display:none">
                      <td>Libro de referencia:</td>
                      <td colspan="5">
                        <select id="cboAnnotationBook" name="cboAnnotationBook" class="selectBox" style="width:532px" title="" onchange="return updateUserInterface(this);" >
                          <option value="">( Seleccionar el libro de registro donde se encuentra )</option>
                        </select>
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr id="divAnnotationEditorRow3" style="display:none">
                      <td>N�mero de inscripci�n:</td>
                      <td>
                        <input id="txtAnnotationNumber" name="txtAnnotationNumber" onkeypress="return integerKeyFilter(this);" type="text" class="textBox" style="width:35px;margin-right:0px" title="" maxlength="8" runat="server" />
                        <input id="chkUseBisAnnotationNumber" type="checkbox" runat="server" style="vertical-align:middle" tabindex="-1" />Bis&nbsp; &nbsp;
                        De la imagen:
                      </td>
                      <td><input id="txtAnnotationImageStartIndex" name="txtAnnotationImageStartIndex" type="text" class="textBox" style="width:40px" onkeypress="return integerKeyFilter(this);" title="" maxlength="4" runat="server" /></td>
                      <td>a la imagen:</td>
                      <td>
                        <input id="txtAnnotationImageEndIndex" name="txtAnnotationImageEndIndex" type="text" class="textBox" style="width:40px" title="" onkeypress="return integerKeyFilter(this);" maxlength="4" runat="server" />&nbsp;
                        <img src="../themes/default/buttons/search.gif" alt="" title="Ejecuta la b�squeda" style="margin-left:-8px" onclick="doOperation('showAdditionalImage')" />
                        &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        <input type="button" value="No legible" class="button" style="width:64px" onclick='doOperation("appendNoLegibleAnnotation")' title="Anexa una anotaci�n o limitaci�n como no legible para ser registrada posteriormente" />
                      </td>
                      <td>&nbsp;</td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr id="divAnnotationEditorRow4" style="display:none">
                      <td>Fecha de presentaci�n:</td>
                      <td>
                        <input type="text" class="textBox" id='txtAnnotationPresentationDate' name='txtAnnotationPresentationDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                        <img id='imgAnnotationPresentationDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtAnnotationPresentationDate'), getElement('imgAnnotationPresentationDate'));" title="Despliega el calendario" alt="" style="margin-left:-4px" />
                        &nbsp; Hora:
                      </td>
                      <td><input id="txtAnnotationPresentationTime" name="txtAnnotationPresentationTime" type="text" class="textBox" style="width:40px" maxlength="5" title="" onkeypress='return hourKeyFilter(this);' runat="server" /></td>
                      <td>Autorizaci�n:</td>
                      <td>
                        <input id='txtAnnotationAuthorizationDate' name='txtAnnotationAuthorizationDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                        <img id='imgAnnotationAuthorizationDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtAnnotationAuthorizationDate'), getElement('imgAnnotationAuthorizationDate'));" title="Despliega el calendario" alt=""  style="margin-left:-4px" />
                        &nbsp; &nbsp; &nbsp;
                        <input type="button" value="Heredar" class="button" style="width:64px" onclick='doOperation("inheritAnnotationData")' title="Hereda la informaci�n de la inscripci�n del predio a esta anotaci�n o limitaci�n" />
                      </td>
                      <td colspan="2" class="lastCell">&nbsp;</td>
                    </tr>
                    <tr id="divAnnotationEditorRow4bis" style="display:none">
                      <td class="lastCell" colspan="7">
                        <empiriaControl:LRSRecordingPaymentEditorControl ID="oAnnotationPaymentEditorControl" runat="server" />
                      </td>
                    </tr>
                    <tr id="divAnnotationEditorRow5" style="display:none">
                      <td>El C. Registrador: &nbsp; Lic.</td>
                      <td colspan="4">
                        <select id="cboAnnotationAuthorizedBy" name="cboAnnotationAuthorizedBy" class="selectBox" style="width:374px" title="">
                          <option value="">( Seleccionar al C. Oficial Registrador )</option>
                        </select>
                        &nbsp; &nbsp;
                        <input type="button" value="Agregar anotaci�n" class="button" style="width:110px" onclick='doOperation("appendAnnotation")' title="Anexa la anotaci�n o limitaci�n a la inscripci�n actual" />
                      </td>
                      <td>&nbsp;</td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>              
                  </table>
                  <table id="divAnnotationEditorRow6" class="editionTable" style="display:none">
                    <tr><td class="subTitle" colspan="7">Informaci�n general de la anotaci�n</td></tr>
                    <tr><td colspan="7"><span id="spanAnnotationDocumentEditor" runat="server"></span></td></tr>
                    <tr>
                      <td>Observaciones:<br /><br /></td>
                      <td colspan="5">
                        <textarea id="txtAnnotationObservations" name="txtAnnotationObservations" class="textArea" style="width:560px" cols="120" rows="2" runat="server"></textarea>
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="separator">
                &nbsp;
                </td>
              </tr>
              <tr>
                <td>
                  <table>
                    <tr>
                      <td nowrap='nowrap'>Ir a la inscripci�n: &nbsp;<input id="txtGoToRecording" name="txtGoToRecording" type="text" class="textBox" maxlength="5" style="width:35px;margin-right:0px" onkeypress="return integerKeyFilter(this);" runat="server" /></td>
                      <td nowrap='nowrap'><img src="../themes/default/buttons/search.gif" alt="" onclick="return doOperation('gotoRecording')" title="Ejecuta la b�squeda" /></td>
                      <td width='88px' nowrap='nowrap'>&nbsp;</td>
                      <td><img src='../themes/default/buttons/first.gif' onclick='doOperation("moveToRecording", "First");' title='Muestra la primera inscripci�n' alt='' /></td>
                      <td><img src='../themes/default/buttons/previous.gif' onclick='doOperation("moveToRecording", "Previous");' title='Muestra la inscripci�n anterior' alt='' /></td>
                      <td><img src='../themes/default/buttons/next.gif' onclick='doOperation("moveToRecording", "Next");' title='Muestra la siguiente inscripci�n' alt='' /></td>
                      <td><img src='../themes/default/buttons/last.gif' onclick='doOperation("moveToRecording", "Last");' title='Muestra la �ltima inscripci�n' alt='' /></td>
                      <td width='48px' nowrap='nowrap'>&nbsp;</td>
                      <td nowrap='nowrap'>
                      <input type="button" value="Actualizar" class="button" style="width:68px" onclick='doOperation("refresh")' />
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                      <input type="button" value="Nueva inscripci�n" class="button" style="width:108px" onclick='doOperation("newRecording")' /></td>												
                    </tr>
                  </table>
                </td>
              </tr>
            </table>  <!-- tabStripItemView_0 !-->

            <table id="tabStripItemView_1" class="editionTable" style="display:none;">
              <tr>
                <td class="lastCell">
                  <iframe id="ifraItemEditor" style="z-index:99;left:0px;top:0px;" 
                          marginheight="0" marginwidth="0" frameborder="0" scrolling="no"
                          src="" width="670px" visible="false" >
                  </iframe>
                </td>
              </tr>
            </table> <!-- tabStripItemView_1 !-->
            
     
            <table id="tabStripItemView_2" class="editionTable" style="display:none;">
              <tr>
                <td class="subTitle">Buscar en este libro</td>
              </tr>
              <tr>
                <td>
                  <table class="editionTable">
                    <tr>
                      <td>Buscar en:</td>
                      <td>
                        <select id="Select4" name="cboZone" class="selectBox" style="width:164px" runat='server' title="">
                          <option value="">( Todos los campos )</option>
                          <option value="">N�mero de inscripci�n</option>
                          <option value="">Involucrados</option>
                          <option value="">Folio electr�nico</option>
                          <option value="">Clave catastral</option>
                          <option value="">Domicilio del predio</option>
                          <option value="">Recibo de pago</option>
                          <option value="">Acto jur�dico</option>
                          <option value="">Fedatario</option>
                        </select>
                      </td>
                      <td>
                        <input type="text" class="textBox" id='Text23' name='txtExternalNumber' style="width:230px" maxlength="32" runat='server' title="" />
                        <img src="../themes/default/buttons/search.gif" alt="" onclick="return doOperation('loadData')" title="Ejecuta la b�squeda" style="margin-left:-4px" />												
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr>
                      <td>Presentaci�n:</td>
                      <td colspan="2">
                        <input type="text" class="textBox" id='txtSearchPresentationFromDate' name='txtSearchPresentationFromDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                        <img id='img2' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtSearchPresentationFromDate'), getElement('imgFromDate'));" title="Despliega el calendario" alt="" />
                        Al d�a:
                        <input type="text" class="textBox" id='txtSearchPresentationToDate' name='txtSearchPresentationToDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                        <img id='img3' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtSearchPresentationToDate'), getElement('imgFromDate'));" title="Despliega el calendario" alt="" />													
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr>
                      <td>Autorizaci�n:</td>
                      <td colspan="2">
                        <input type="text" class="textBox" id='txtSearchAuthorizationFromDate' name='txtSearchAuthorizationFromDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                        <img id='img4' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtSearchAuthorizationFromDate'), getElement('imgFromDate'));" title="Despliega el calendario" alt="" />
                        Al d�a:
                        <input type="text" class="textBox" id='txtSearchAuthorizationToDate' name='txtFromDate' style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr>
                <td class="subTitle">�ndice de inscripciones</td>
              </tr>
              <tr>
                <td>
                  <table class="editionTable">
                    <tr>
                      <td>
                        <%=GetRecordingsViewerGrid()%>
                      </td>
                      <td class="lastCell">&nbsp;</td>
                    </tr>
                    <tr>
                      <td>
                        <span class="leftItem"><%=recordingBook.Recordings.Count%> inscripciones registradas.</span>
                        <span class="rightItem">P�gina
                        <select class="selectBox" id="cboRecordingViewerPage" name="cboRecordingViewerPage" 
                                style="width:45px" runat="server" onchange="doOperation('refreshRecordingViewer')" >
                        </select>de <%=RecordingViewerPages()%>&nbsp;</span>
                      </td>
                      <td class="lastCell">&nbsp;</td>
                     </tr>
                  </table>
                </td>
              </tr>
            </table> <!-- tabStripItemView_2 !-->
              
            <table id="tabStripItemView_3" class="editionTable" style="display:none;">
              <tr><td class="subTitle">Informaci�n pendiente en este libro</td></tr>
              <tr><td>Aqu� va el visualizador</td></tr>
            </table> <!-- tabStripItemView_3 !-->
            
            </td>
          </tr>
        </table>
      </div> <!--divContent!-->		
    </div> <!-- end divBody !-->  
  </div> <!-- end divCanvas !-->
</form>
<iframe id="ifraCalendar" style="z-index:99;left:0px;visibility:hidden;position:relative;top:0px" 
    marginheight="0"  marginwidth="0" frameborder="0" scrolling="no"
    src="../user.controls/calendar.aspx" width="100%">
</iframe>
</body>
  <script type="text/javascript">
  /* <![CDATA[ */	
  
  function doPageCommand(commandName, commandArguments) {
    switch (commandName) {
      case 'refreshViewCmd':
        window.location.reload(false);
        //gbSended = true;
        return true;
      case 'changeBehaviorCmd':
        doChangeBehavior();
        gbSended = false;
        return true;
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
      case 'registerAsNoLegibleRecording':
        success = registerAsNoLegibleRecording();
        break;
      case 'registerAsObsoleteRecording':
        success = registerAsObsoleteRecording();
        break;
      case 'registerAsPendingRecording':
        success = registerAsPendingRecording();
        break;
      case 'registerAsIncompleteRecording':
        success = registerAsIncompleteRecording();
        <% if (!recording.IsNew) { %>
          command = 'appendRecordingAct';
        <% } %>
        break;
      case 'appendAnnotation':
        success = appendAnnotation();
        break;
      case 'appendNoLegibleAnnotation':
        success = appendNoLegibleAnnotation();
        break;
      case 'deleteAnnotation':
        success = deleteAnnotation(arguments[1], arguments[2]);
        break;
      case 'showAnnotationsEditor':
        showAnnotationsEditor();
        return;
      case 'newRecording':
        success = true;
        break;
      case 'addPropertyToRecordingAct':
        addPropertyToRecordingAct(arguments[1], arguments[2]);
        return;
      case 'modifyRecordingActType':
        modifyRecordingActType(arguments[1], arguments[2]);
        return;
      case 'editRecordingAct':
        editRecordingAct(arguments[1]);
        return;
      case 'editAnnotation':
        editAnnotation(arguments[1], arguments[2]);
        return;
      case 'editProperty':
        editProperty(arguments[1], arguments[2]);
        return;
      case 'deleteRecordingAct':
        deleteRecordingAct(arguments[1], arguments[2]);
        return;
      case 'deleteRecordingActProperty':
        deleteRecordingActProperty(arguments[1], arguments[2]);
        return;
      case 'inheritAnnotationData':
        inheritAnnotationData();
        return;
      case "upwardRecordingAct":
        upwardRecordingAct(arguments[1], arguments[2]);
        return;
      case "downwardRecordingAct":
        downwardRecordingAct(arguments[1], arguments[2]);
        return;
      case 'selectRecordingActOperation':
        alert("Requiero se seleccione una operaci�n de la lista.");
        return;
      case 'gotoImage':
        gotoImage();
        return;
      case 'moveToImage':
        moveToImage(arguments[1]);
        return;
      case 'zoomImage':
        return doZoom();
      case 'insertEmptyImageBefore':
        if (!getElement('cboImageOperation').disabled) {
          insertEmptyImageBefore();
        }
        return;
      case 'deleteImage':
        if (!getElement('cboImageOperation').disabled) {
          deleteImage();
        }
        return;
      case 'refresh':
        sendPageCommand(command);
        return;
      case 'refreshImages':
        if (!getElement('cboImageOperation').disabled) {
          refreshImages();
        }
        return;		
      case 'gotoRecording':
        gotoRecording();
        return;
      case 'moveToRecording':
        sendPageCommand(command, "goto=" + arguments[1]);
        return;
      case 'showAnotherRecording':
        showAnotherRecording();
        return;
      case "showAdditionalImage":
        showAdditionalImage();
        break;
      case "onclick_editRecordingForEdition":
        onclick_editRecordingForEdition();
        return;
      case 'saveRecording':
        success = saveRecording();
        break;	
      case 'deleteRecording':
        deleteRecording();
        break;
      case 'refreshRecordingViewer':
        refreshRecordingViewer();
        return;
      case 'refreshRecording':
        window.location.reload(false);
        return;
      case 'gotoRecordingBook':
        gotoRecordingBook();
        return;
      default:
        alert("La operaci�n '" + command + "' no ha sido definida en el programa.");
        return;
    }
    if (success) {
      sendPageCommand(command);
      gbSended = true;
    }
  }

  function showAnotherRecording() {
    if (getElement('cboAnotherRecordingBook').value.length == 0) {
      alert("Requiero se seleccione el libro registral que se desea consultar.");
      return;
    }
    var source = "recording.book.analyzer.aspx?";
    source += "bookId=" + getElement('cboAnotherRecordingBook').value;

    if (getElement('cboAnotherRecording').value.length != 0) {
      source += "&id=" + getElement('cboAnotherRecording').value;
    }
    createNewWindow(source);
  }


  function gotoRecordingBook(recordingBookId, recordingId) {
    var source = "recording.book.analyzer.aspx?";
    source += "bookId=" + recordingBookId;
    source += "&id=" + recordingId;
    createNewWindow(source);
  }

  function inheritAnnotationData() {
    var sMsg = "Heredar los datos de la inscripci�n principal.\n\n";

    sMsg += "Esta operaci�n copiar� la informaci�n de la inscripci�n principal hacia esta nueva anotaci�n,";
    sMsg += "con excepci�n del n�mero de inscripci�n, del rango de im�genes y de las observaciones.\n\n";

    sMsg += "�Heredo los datos de la inscripci�n principal hacia esta anotaci�n o limitaci�n?";

    if (!confirm(sMsg)) {
      return false;
    }
    var data = getRecordingRawData();

    var dataArray = data.split('|');
    
    getElement('txtAnnotationPresentationDate').value = dataArray[0];
    getElement('txtAnnotationPresentationTime').value = dataArray[1];
    getElement('txtAnnotationAuthorizationDate').value = dataArray[2];

    getElement('<%=oAnnotationPaymentEditorControl.ClientID%>_txtRecordingPayment').value = dataArray[3];
    getElement('<%=oAnnotationPaymentEditorControl.ClientID%>_cboRecordingPaymentCurrency').value = dataArray[4];
    getElement('<%=oAnnotationPaymentEditorControl.ClientID%>_txtRecordingPaymentReceipt').value = dataArray[5];
    getElement('<%=oAnnotationPaymentEditorControl.ClientID%>_txtRecordingPaymentAdditionalReceipts').value = dataArray[6];

    getElement('cboAnnotationAuthorizedBy').value = dataArray[7];
    getElement('cboAnnotationDocumentType').value = dataArray[8];
    <%=oAnnotationDocumentEditor.ClientID%>_inheritAnnotationData(<%=recording.Id%>);

    return true;
  }

  function getRecordingRawData() {
    var ajaxURL = "../ajax/land.registration.system.data.aspx";
    ajaxURL += "?commandName=getRecordingRawData";
    ajaxURL += "&recordingId=<%=recording.Id%>";

    return invokeAjaxMethod(false, ajaxURL, null);
  }

  function registerAsObsoleteRecording() {
    <% if (recording.RecordingActs.Count > 0) { %>
      alert("Esta inscripci�n contiene actos jur�dicos, raz�n por la cual no puede cambiarse al estado de no vigente.");
      return false;
    <% } %>
    if (!validateRecordingStep1()) {
      return false;
    }
    if (!validateRecordingSemantics()) {
      return false;
    }
    var sMsg = "Registrar la inscripci�n como NO VIGENTE\n\n";
    
    sMsg += "Esta operaci�n guardar� la inscripci�n como NO VIGENTE,\n";
    sMsg += "con la siguiente informaci�n:\n\n";

    sMsg += getRecordingDataForm();
    
    sMsg += "�Registro la inscripci�n como NO VIGENTE?";
    
    return confirm(sMsg);	
  }
  
  function registerAsNoLegibleRecording() {
    if (!validateRecordingStep1()) {
      return false;
    }
    if (!validateRecordingSemantics()) {
      return false;
    }
    var sMsg = "Registrar la inscripci�n como no legible\n\n";
    
    sMsg += "Esta operaci�n guardar� la inscripci�n como no legible, para\n";
    sMsg += "que posteriormente se busque en legajos u otros documentos la\n";
    sMsg += "informaci�n correcta:\n\n";

    sMsg += getRecordingDataForm();
    
    sMsg += "�Registro la inscripci�n como no legible?";
    
    return confirm(sMsg);
  }
  
  function registerAsPendingRecording() {
    if (!validateRecordingStep1()) {
      return false;
    }
    if (!validateRecordingStep2()) {
      return false;
    }
    if (getElement("txtObservations").value == '') {
      alert("Requiero un texto descriptivo que indique el motivo por el que se dejar� pendiente esta inscripci�n.");
      return false;
    }
    if (!validateRecordingSemantics()) {
      return false;
    }
    var sMsg = "Registrar la inscripci�n como pendiente.\n\n";
    
    sMsg += "Esta operaci�n guardar� la inscripci�n como pendiente, para\n";
    sMsg += "que en un futuro se agregue la informaci�n faltante:\n\n";

    sMsg += getRecordingDataForm();
    
    sMsg += "�Registro esta inscripci�n como pendiente, para su an�lisis posterior?";
    
    return confirm(sMsg);
  }
  
  function registerAsIncompleteRecording() {
    var onlyChangeRecording = (arguments.length == 1);
    if (!validateRecordingStep1()) {
      return false;
    }
    if (!validateRecordingStep2()) {
      return false;
    }
    if (!onlyChangeRecording) {
      if (!validateRecordingAct()) {
        return false;
      }
    }
    if (!validateRecordingSemantics()) {
      return false;
    }
    if (onlyChangeRecording) {
      return confirm("�Guardo los cambios efectuados en esta inscripci�n?");	  
    }
    <% if (recording.IsNew) { %>
      var sMsg = "Registrar la inscripci�n como vigente\n\n";
      
      sMsg += "Esta operaci�n guardar� la inscripci�n como vigente, con la\n";
      sMsg += "siguiente informaci�n:\n\n";

      sMsg += getRecordingDataForm();
      
      sMsg += "Acto jur�dico:\t" + getComboOptionText(getElement('cboRecordingActType')) + "\n";
      sMsg += "Predio:\t\t" + getComboOptionText(getElement('cboProperty')) + "\n";
      if (getElement('cboProperty').value == "-1") {
        sMsg += "Folio:\t\t" + getComboOptionText(getElement('cboAnotherProperty')) + "\n\n";
      } else {
        sMsg += "\n";
      }
      sMsg += "�Registro la inscripci�n " + getElement('txtRecordingNumber').value + " como vigente?";
    <% } else { %>
      var sMsg = "Agregar un acto jur�dico vigente\n\n";
      
      sMsg += "Esta operaci�n agregar� el siguiente acto jur�dico a esta inscripci�n:\n\n";
          
      sMsg += "Libro:\t\t<%=recordingBook.FullName%>\n";
      sMsg += "Inscripci�n:\t" + getElement('txtRecordingNumber').value + "\n\n";
      
      sMsg += "Acto jur�dico:\t" + getComboOptionText(getElement('cboRecordingActType')) + "\n";
      sMsg += "Predio:\t\t" + getComboOptionText(getElement('cboProperty')) + "\n";	
      if (getElement('cboProperty').value == "-1") {
        sMsg += "Folio:\t\t" + getComboOptionText(getElement('cboAnotherProperty')) + "\n\n";
      } else {
        sMsg += "\n";
      }
      <% if (base.recording.Status == RecordingStatus.Obsolete) { %>
      sMsg += "IMPORTANTE: La inscripci�n pasar� de estado No vigente a Incompleta.\n\n";
      <% } %>
      sMsg += "�Agrego el acto jur�dico a la inscripci�n " + getElement('txtRecordingNumber').value + "?";			
    <% } %>			
    return confirm(sMsg);
  }

  function insertEmptyImageBefore() {
    var newCurrentImagePosition = getCurrentImage() + 1;
    var newBookImageCount = selectedBookImageCount(null) + 1;
    var sMsg = "Insertar una imagen faltante.\n\n";
    sMsg += "Esta operaci�n insertar� una imagen vac�a en la posici�n\n";
    sMsg += "actual, por lo que la imagen que actualmente se est�\n";
    sMsg += "visualizando en pantalla se volver� la n�mero " + newCurrentImagePosition + ", y el\n";
    sMsg += "libro ahora contendr� " +  newBookImageCount + " im�genes.\n\n";
    
    sMsg += "�Inserto una imagen vac�a en la posici�n actual?";
    
    if (confirm(sMsg)) {
      sendPageCommand("insertEmptyImageBefore");
      return;
    }
  }

  function deleteImage() {
    var newBookImageCount = selectedBookImageCount(null) - 1;
    var sMsg = "Eliminar una imagen duplicada o incorrecta.\n\n";
    sMsg += "Esta operaci�n eliminar� la imagen que actualmente\n";
    sMsg += "se est� visualizando en pantalla, por lo que el libro\n";
    sMsg += "ahora contendr� " +  newBookImageCount + " im�genes.\n\n";
    
    sMsg += "�Elimino la imagen que actualmente se est� visualizando\n";
    sMsg += "y que ocupa la posici�n " + getCurrentImage() + "?";

    if (confirm(sMsg)) {
      sendPageCommand("deleteImage");
      return;
    }
  }
  
  function refreshImages() {
    var newBookImageCount = selectedBookImageCount(null) - 1;
    var sMsg = "Actualizar las im�genes del libro.\n\n";
    sMsg += "Esta operaci�n actualizar� todos los nombres de las im�genes que\n";
    sMsg += "conforman este libro, y recalcular� las estad�sticas de las mismas.\n\n";
    
    sMsg += "�Actualizo todos los nombres de las im�genes y las estad�sticas?";

    if (confirm(sMsg)) {
      sendPageCommand("refreshImagesStatistics");
      return;
    }	
  }

  function addPropertyToRecordingAct(recordingActId, propertyId) {
    var itemId = "_" + recordingActId + "_" + propertyId;
      
    var sMsg = "Agregar otra propiedad al acto jur�dico.\n\n";		
    sMsg += "Esta operaci�n agregar� una nueva propiedad al siguiente acto jur�dico:\n\n";
    sMsg += getInnerText('ancRecordingAct_' + recordingActId).toUpperCase() + "\n";
    sMsg += "N�mero de acto:\t" + getInnerText('ancRecordingActIndex' + itemId) + "\n";
    sMsg += "Propiedad base:\t" + getInnerText('ancRecordingActProperty' + itemId) + "\n\n";
    
    sMsg += "�Agrego una nueva propiedad al acto jur�dico seleccionado?";
    
    if (confirm(sMsg)) {
      sendPageCommand("appendPropertyToRecordingAct", "recordingActId=" + recordingActId);
      return;
    }
  }	

  function editProperty(propertyId, recordingActId) {	
    var oEditor = getElement("ifraItemEditor");
    
    oEditor.src = "property.editor.aspx?propertyId=" + propertyId + "&recordingActId=" + recordingActId;
    
    oEditor.visible = true;
    doCommand('onClickTabStripCmd', getElement('tabStripItem_1'));
    getElement("top").scrollIntoView(false);
    return true;
  }

  function editRecordingAct(recordingActId) {
    var oEditor = getElement("ifraItemEditor");
    
    oEditor.src = "recording.act.editor.aspx?id=" + recordingActId;

    oEditor.visible = true;
    doCommand('onClickTabStripCmd', getElement('tabStripItem_1'));
    getElement("top").scrollIntoView(false);
    return true;
  }

  function editAnnotation(recordingId, annotationId) {
    showRecordingImages(recordingId);
    editRecordingAct(annotationId);
  }

  function showRecordingImages(recordingId) {
    getElement("cboRecordingBookSelector").value = recordingId;
    if (getElement("cboRecordingBookSelector").selectedIndex == 0) {
      getElement("hdnCurrentImagePosition").value = <%=currentImagePosition%>;
      if (existsElement("cboImageOperation")) {
        getElement("cboImageOperation").disabled = false;
      }
    } else if (getElement("cboRecordingBookSelector").value.length != 0) {
      getElement("hdnCurrentImagePosition").value = -1;
      if (existsElement("cboImageOperation")) {
        getElement("cboImageOperation").disabled = true;
      }
    } else if (getElement("cboRecordingBookSelector").value.length == 0) {
      return;
    }
    moveToImage("refresh");
  }

  function deleteAnnotation(propertyId, recordingActId) {
    <% if (!User.CanExecute("BatchCapture.Supervisor")) { %>
      showNotAllowedMessage();
      return;
    <% } %>
    var itemKey = "_" + propertyId + "_" + recordingActId;
    var sMsg = "Eliminar la anotaci�n o limitaci�n.\n\n";
    sMsg += "Esta operaci�n eliminar� la siguiente anotaci�n o limitaci�n asociada\n";
    sMsg += "al predio que se detalla:\n\n";
    sMsg += getInnerText('ancAnnotation' + itemKey).toUpperCase() + "\n";
    sMsg += "Folio del predio:\t\t" + getInnerText('ancAnnotationProperty' + itemKey) + "\n";
    sMsg += "Libro de referencia:\t\t" + getInnerText('ancAnnotationBook' + itemKey) + "\n";
    sMsg += "N�mero de inscripci�n:\t" + getInnerText('ancAnnotationNumber' + itemKey) + "\n";
    sMsg += "Fecha de presentaci�n:\t" + getInnerText('ancAnnotationPresentation' + itemKey) + "\n\n";
        
    sMsg += "�Elimino esta anotaci�n o limitaci�n ligada al predio que se indica?";
    
    if (confirm(sMsg)) {
      sendPageCommand("deleteAnnotation", "recordingActId=" + recordingActId + "|propertyId=" + propertyId);
      return;
    }
  }
  
  function deleteRecording() {	
    <% if (!User.CanExecute("BatchCapture.Supervisor")) { %>
      showNotAllowedMessage();
      return false;
    <% } %>  
    <% if (recordingBook.RecordingsClass.NamedKey != "DomainTraslative") { %>
      alert("No puedo eliminar esta inscripci�n debido a que se trata de una anotaci�n de otra inscripci�n.");
      return false;
    <% } %>
    <% if (recording.GetPropertiesAnnotationsList().Count > 0) { %>
      alert("No puedo eliminar esta inscripci�n debido a que contiene anotaciones.");
      return false;
    <% } %>
    <% if (recording.RecordingActs.Count > 0) { %>
      alert("No puedo eliminar esta inscripci�n ya que contiene actos jur�dicos.");
      return false;
    <% } %>
    
    var sMsg = "Eliminar la inscripci�n del libro registral.\n\n";		
    sMsg += "Esta operaci�n eliminar� la siguiente inscripci�n contenida en este libro registral:\n\n";				
    sMsg += "Libro:\t\t<%=recordingBook.FullName%>\n";
    sMsg += "Inscripci�n:\t" + getElement('txtRecordingNumber').value + "\n\n";
    sMsg += "�Elimino la inscripci�n " + getElement('txtRecordingNumber').value + " de este libro?";		
    if (confirm(sMsg)) {
      sendPageCommand("deleteRecording", "id=<%=recording.Id%>");
      return;
    }
  }
  
  function deleteRecordingAct(recordingActId, propertyId) {
    <% if (!User.CanExecute("BatchCapture.Supervisor")) { %>
      showNotAllowedMessage();
      return;
    <% } %>
    if (!validateDeleteRecordingAct(recordingActId)) {
      return false;
    }
    var itemId = "_" + recordingActId + "_" + propertyId;
    
    var sMsg = "Eliminar el acto jur�dico y la propiedad asociada.\n\n";		
    sMsg += "Esta operaci�n eliminar� el siguiente acto jur�dico, junto con ";
    sMsg += "la propiedad que est� asociada al mismo:\n\n";
    sMsg += getInnerText('ancRecordingAct_' + recordingActId).toUpperCase() + "\n";
    sMsg += "Posici�n:\t\t" + getInnerText('ancRecordingActIndex' + itemId) + "\n";
    sMsg += "Propiedad:\t" + getInnerText('ancRecordingActProperty' + itemId) + "\n\n";

    <% if (recording.RecordingActs.Count == 1) { %>
    sMsg += "IMPORTANTE: Este es el �nico acto jur�dico registrado en esta\n";
    sMsg += "inscripci�n. Al eliminarse, tambi�n se cambiar� el estado de la\n";
    sMsg += "inscripci�n a pendiente o incompleta.\n\n";
    <% } %>
    sMsg += "�Elimino este acto jur�dico de la lista de actos vigentes,\n";
    sMsg += "as� como la propiedad asociada a dicho acto?";
    if (confirm(sMsg)) {
      sendPageCommand("deleteRecordingAct", "recordingActId=" + recordingActId);
      return;
    }
  }	
  
  function deleteRecordingActProperty(recordingActId, propertyId) {
    <% if (!User.CanExecute("BatchCapture.Supervisor")) { %>
      showNotAllowedMessage();
      return;
    <% } %>
    if (!validateDeleteRecordingActProperty(recordingActId, propertyId)) {
      return false;
    }
    var itemId = "_" + recordingActId + "_" + propertyId;
    var sMsg = "Eliminar la propiedad relacionada con el acto jur�dico.\n\n";
    
    sMsg += "Esta operaci�n eliminar� la siguiente propiedad relacionada con el\n"
    sMsg += "acto jur�dico que se indica, pero no eliminar� el acto jur�dico en s�:\n\n";							
    sMsg += getInnerText('ancRecordingAct_' + recordingActId).toUpperCase() + "\n";
    sMsg += "N�mero de acto:\t " + getInnerText('ancRecordingActIndex' + itemId) + "\n";
    sMsg += "Propiedad a eliminar: " + getInnerText('ancRecordingActProperty' + itemId) + "\n\n";

    sMsg += "�Elimino esta propiedad relacionada al acto jur�dico que se indica?";		
    
    if (confirm(sMsg)) {
      sendPageCommand("deleteRecordingActProperty", "recordingActId=" + recordingActId + "|propertyId=" + propertyId);
      return;
    }
  }
    
  function modifyRecordingActType(recordingActId, propertyId) {
    <% if (!User.CanExecute("BatchCapture.Supervisor")) { %>
      showNotAllowedMessage();
      return;
    <% } %>
    if (getElement('cboRecordingActType').value == '') {
      alert("Para modificar este acto jur�dico, se debe seleccionar de la lista de actos jur�dicos el nuevo tipo de acto.");
      return false;
    }
    var itemId = "_" + recordingActId + "_" + propertyId;
            
    var sMsg = "Modificar el tipo del acto jur�dico.\n\n";		
    sMsg += "Esta operaci�n modificar� el tipo del siguiente acto jur�dico:\n\n";
    
    sMsg += "Libro:\t\t<%=recordingBook.FullName%>\n";
    sMsg += "Inscripci�n:\t" + getElement('txtRecordingNumber').value + "\n\n";		
    sMsg += getInnerText('ancRecordingAct_' + recordingActId).toUpperCase() + "\n";
    sMsg += "Posici�n:\t\t" + getInnerText('ancRecordingActIndex' + itemId) + "\n"
    sMsg += "Propiedad:\t" + getInnerText('ancRecordingActProperty' + itemId) + "\n\n";
    sMsg += "Nuevo tipo:\t" + getComboOptionText(getElement('cboRecordingActType')) + "\n\n";
    
    sMsg += "�Modifico el acto jur�dico ubicado en la posici�n " + getInnerText('ancRecordingActIndex' + itemId) + "?";
    if (confirm(sMsg)) {
      sendPageCommand("modifyRecordingActType", "recordingActId=" + recordingActId);
      return;
    }
  }

  function downwardRecordingAct(recordingActId, propertyId) {
    var itemId = "_" + recordingActId + "_" + propertyId;
    
    var sMsg = "Bajar este acto en la secuencia jur�dica de la inscripci�n.\n\n";		
    sMsg += "Esta operaci�n ubicar� este acto jur�dico por debajo del acto\n";
    sMsg += "jur�dico que lo precede dentro de esta inscripci�n:\n\n";
    sMsg += getInnerText('ancRecordingAct_' + recordingActId).toUpperCase() + "\n";
    sMsg += "Posici�n actual:\t" + Number(getInnerText('ancRecordingActIndex' + itemId)) + "\n";
    sMsg += "Nueva posici�n:\t" + Number(Number(getInnerText('ancRecordingActIndex' + itemId)) + 1).toString() + "\n";
    sMsg += "Propiedad base:\t" + getInnerText('ancRecordingActProperty' + itemId) + "\n\n";
    sMsg += "La secuencia jur�dica indica qu� acto jur�dico antecede a otro u\n";
    sMsg += "otros dentro de una misma inscripci�n y para la misma propiedad.\n\n";		
    sMsg += "�Bajo este acto jur�dico dentro de la inscripci�n?";
    
    if (confirm(sMsg)) {
      sendPageCommand("downwardRecordingAct", "recordingActId=" + recordingActId);
      return;
    }
  }

  function upwardRecordingAct(recordingActId, propertyId) {
    var itemId = "_" + recordingActId + "_" + propertyId;
    
    var sMsg = "Subir este acto en la secuencia jur�dica de la inscripci�n.\n\n";		
    sMsg += "Esta operaci�n ubicar� este acto jur�dico por encima del acto\n";
    sMsg += "jur�dico que lo antecede dentro de esta inscripci�n:\n\n";
    sMsg += getInnerText('ancRecordingAct_' + recordingActId).toUpperCase() + "\n";
    sMsg += "Posici�n actual:\t" + Number(getInnerText('ancRecordingActIndex' + itemId)) + "\n";
    sMsg += "Nueva posici�n:\t" + Number(Number(getInnerText('ancRecordingActIndex' + itemId)) - 1).toString() + "\n";
    sMsg += "Propiedad base:\t" + getInnerText('ancRecordingActProperty' + itemId) + "\n\n";
    sMsg += "La secuencia jur�dica indica qu� acto jur�dico antecede a otro u\n";
    sMsg += "otros dentro de una misma inscripci�n y para la misma propiedad.\n\n";		
    sMsg += "�Subo este acto jur�dico dentro de la inscripci�n?";
    
    if (confirm(sMsg)) {
      sendPageCommand("upwardRecordingAct", "recordingActId=" + recordingActId);
      return;
    }
  }

  function validateAnnotationSemantics() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=validateAnnotationSemanticsCmd";
    url += "&annotationTypeId=" + getElement("cboAnnotation").value;
    url += "&annotationBookId=" + getElement("cboAnnotationBook").value;
    url += "&propertyId=" + getElement("cboAnnotationProperty").value;    
    url += "&number=" + getElement("txtAnnotationNumber").value;
    url += "&useBisNumber=" + getElement("chkUseBisAnnotationNumber").checked;    
    url += "&imageStartIndex=" + getElement("txtAnnotationImageStartIndex").value;
    url += "&imageEndIndex=" + getElement("txtAnnotationImageEndIndex").value;
    url += "&presentationTime=" + getElement("txtAnnotationPresentationDate").value + " " + getElement("txtAnnotationPresentationTime").value;
    url += "&authorizationDate=" + getElement("txtAnnotationAuthorizationDate").value;
    url += "&authorizedById=" + getElement("cboAnnotationAuthorizedBy").value;

    return invokeAjaxValidator(url);
  }

  function validateDeleteRecordingAct(recordingActId) {
    var ajaxURL = "../ajax/land.registration.system.data.aspx";
    ajaxURL += "?commandName=validateDeleteRecordingActCmd";
    ajaxURL += "&recordingId=<%=recording.Id%>";
    ajaxURL += "&recordingActId=" + recordingActId;

    return invokeAjaxValidator(ajaxURL);
  }
    
  function validateDeleteRecordingActProperty(recordingActId, propertyId) {
    var ajaxURL = "../ajax/land.registration.system.data.aspx";
    ajaxURL += "?commandName=validateDeleteRecordingActPropertyCmd";
    ajaxURL += "&recordingId=<%=recording.Id%>";
    ajaxURL += "&recordingActId=" + recordingActId;
    ajaxURL += "&propertyId=" + propertyId;

    return invokeAjaxValidator(ajaxURL);
  }
 
  function validateRecordingSemantics() {
    <% if (!recording.IsNew) { %>
      if (existsElement("btnSaveRecording") && getElement("btnSaveRecording").disabled) {
        return true;
      }
    <% } %>
    var ajaxURL = "../ajax/land.registration.system.data.aspx";
    ajaxURL += "?commandName=validateRecordingSemanticsCmd";
    ajaxURL += "&recordingBookId=<%=recordingBook.Id%>";
    ajaxURL += "&recordingId=<%=recording.Id%>";
    ajaxURL += "&number=" + getElement("txtRecordingNumber").value;
    ajaxURL += "&useBisNumber=" + getElement("chkUseBisRecordingNumber").checked;
    ajaxURL += "&imageStartIndex=" + getElement("txtImageStartIndex").value;
    ajaxURL += "&imageEndIndex=" + getElement("txtImageEndIndex").value;
    ajaxURL += "&presentationTime=" + getElement("txtPresentationDate").value + " " + getElement("txtPresentationTime").value;
    ajaxURL += "&authorizationDate=" + getElement("txtAuthorizationDate").value;
    ajaxURL += "&authorizedById=" + getElement("cboAuthorizedBy").value;

    return invokeAjaxValidator(ajaxURL);
  }

  function appendAnnotation() {
    if (!validateAnnotationStep1()) {
      return false;
    }
    if (!validateAnnotationStep2()) {
      return false;
    }
    if (!validateAnnotationSemantics()) {
      return false;
    }
    var currentAnnotationId = findAnnotationIdWithEditorData();
    if (currentAnnotationId > 0) {
      return appendPropertyToAnnotation(currentAnnotationId);
    }
    
    var sMsg = "Registrar la anotaci�n o limitaci�n\n\n";
    
    sMsg += "Esta operaci�n anexar� una anotaci�n sobre la inscripci�n actual, con la\n";
    sMsg += "siguiente informaci�n:\n\n";

    sMsg += getAnnotationDataForm();

    sMsg += "�Registro esta anotaci�n o limitaci�n?";

    return confirm(sMsg);
  }
  
  function appendPropertyToAnnotation(annotationId) {
    var sMsg = "Agregar un predio a una anotaci�n o limitaci�n ya existente.\n\n";
    
    sMsg += "Esta operaci�n anexar� el predio con folio " + getComboOptionText(getElement('cboAnnotationProperty')) + "\n";
    sMsg += "a la siguiente anotaci�n o limitaci�n ya existente:\n\n";

    sMsg += getAnnotationDataForm();

    sMsg += "�Agrego el predio " + getComboOptionText(getElement('cboAnnotationProperty')) + " a la anotaci�n que se indica?";

    if (confirm(sMsg)) {
      sendPageCommand("appendPropertyToAnnotation", "annotationId=" + annotationId);
      return;
    } else {
      return false;
    }
  }

  function findAnnotationIdWithEditorData() {
    var url = "../ajax/land.registration.system.data.aspx?commandName=findAnnotationIdCmd";
    url += "&annotationBookId=" + getElement("cboAnnotationBook").value;
    url += "&annotationTypeId=" + getElement("cboAnnotation").value;    
    url += "&propertyId=" + getElement("cboAnnotationProperty").value;    
    url += "&number=" + getElement("txtAnnotationNumber").value;
    url += "&useBisNumber=" + getElement("chkUseBisAnnotationNumber").checked;    
    url += "&imageStartIndex=" + getElement("txtAnnotationImageStartIndex").value;
    url += "&imageEndIndex=" + getElement("txtAnnotationImageEndIndex").value;
    url += "&presentationTime=" + getElement("txtAnnotationPresentationDate").value + " " + getElement("txtAnnotationPresentationTime").value;
    url += "&authorizationDate=" + getElement("txtAnnotationAuthorizationDate").value;
    url += "&authorizedById=" + getElement("cboAnnotationAuthorizedBy").value;

    var annotationId = invokeAjaxMethod(false, url, null);
    
    return Number(annotationId);
  }
  
  function appendNoLegibleAnnotation() {
    if (getElement('txtAnnotationImageStartIndex').value.length == 0 && getElement('txtAnnotationImageEndIndex').value.length == 0) {
      getElement('txtAnnotationImageStartIndex').value = '1';
      getElement('txtAnnotationImageEndIndex').value = '1';
    }  
    if (!validateAnnotationStep1()) {
      return false;
    }
    if (!validateAnnotationSemantics()) {
      return false;
    }
    var sMsg = "Registrar la anotaci�n o limitaci�n como no legible\n\n";
    
    sMsg += "Esta operaci�n anexar� una anotaci�n sobre la inscripci�n actual\n";
    sMsg += "con el estado de no legible, para que posteriormente se busque en\n";
    sMsg += "legajos u otros documentos la informaci�n correcta:\n\n";

    sMsg += getAnnotationDataForm();

    sMsg += "�Registro la anotaci�n o limitaci�n como NO LEGIBLE?";
    
    return confirm(sMsg);		
  }

  function updateUserInterface(oControl) {
    if (oControl == null) {
      return;
    }
    if (oControl == getElement("cboRecordingActTypeCategory")) {
      resetRecordingsTypesCombo();
    } else if (oControl == getElement("cboAnnotationCategory")) {
      resetAnnotationsTypesCombo();
      resetAnnotationsBooksCombo();
      resetAnnotationsOfficialsCombo();
    } else if (oControl == getElement("cboProperty")) {
      showRegisteredPropertiesSection();
    } else if (oControl == getElement("cboAnotherRecorderOffice")) {
      resetAnotherRecordingBooksCombo();
    } else if (oControl == getElement("cboAnotherRecordingBook")) {
      resetAnotherRecordingsCombo();
    } else if (oControl == getElement("cboAnotherRecording")) {
      resetAnotherPropertiesCombo();
    } else if (oControl == getElement("cboAnnotationBook")) {
      resetAnnotationsOfficialsCombo();
    } else if (oControl == getElement("cboRecordingType")) {
      <%=oRecordingDocumentEditor.ClientID%>_updateUserInterface(getComboSelectedOption("cboRecordingType").title);
    } else if (oControl == getElement("cboAnnotationDocumentType")) {
      <%=oAnnotationDocumentEditor.ClientID%>_updateUserInterface(getComboSelectedOption("cboAnnotationDocumentType").title); 
    }
  }

  function resetAnotherRecordingBooksCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingBooksStringArrayCmd";
    if (getElement("cboAnotherRecorderOffice").value.length != 0) {
      url += "&recorderOfficeId=" + getElement("cboAnotherRecorderOffice").value;
    } else {
      url += "&recorderOfficeId=0";
    }
    url += "&recordingActTypeCategoryId=1051";

    invokeAjaxComboItemsLoader(url, getElement("cboAnotherRecordingBook"));

    resetAnotherRecordingsCombo();
  }

  function resetAnotherRecordingsCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingNumbersStringArrayCmd";
    if (getElement("cboAnotherRecordingBook").value.length != 0) {
      url += "&recordingBookId=" + getElement("cboAnotherRecordingBook").value;
    } else {
      url += "&recordingBookId=0";
    }
    invokeAjaxComboItemsLoader(url, getElement("cboAnotherRecording"));
    resetAnotherPropertiesCombo();
  }
    
  function resetAnotherPropertiesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingPropertiesArrayCmd";
    if (getElement("cboAnotherRecording").value.length != 0) {
      url += "&recordingId=" + getElement("cboAnotherRecording").value; 
    } else {
      url += "&recordingId=0"; 
    }
    invokeAjaxComboItemsLoader(url, getElement("cboAnotherProperty"));
  }

  function showRegisteredPropertiesSection() {
    if (getElement("cboProperty").value == "-1") {
      getElement("divRegisteredPropertiesSection").style.display = "inline";
    } else {
      getElement("divRegisteredPropertiesSection").style.display = "none";
    }
  }

  function resetRecordingsTypesCombo() {    
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingTypesStringArrayCmd";
    url += "&recordingActTypeCategoryId=" + getElement("cboRecordingActTypeCategory").value; 

    invokeAjaxComboItemsLoader(url, getElement("cboRecordingActType"));
  }

  function resetAnnotationsTypesCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getAnnotationTypesStringArrayCmd";
    url += "&annotationTypeCategoryId=" + getElement("cboAnnotationCategory").value; 

    invokeAjaxComboItemsLoader(url, getElement("cboAnnotation"))
  }
  
  function resetAnnotationsOfficialsCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getAnnotationsOfficialsStringArrayCmd";
    url += "&recordingBookId=" + getElement("cboAnnotationBook").value;

    invokeAjaxComboItemsLoader(url, getElement("cboAnnotationAuthorizedBy"))
  }

  function resetAnnotationsBooksCombo() {
    var url = "../ajax/land.registration.system.data.aspx";
    url += "?commandName=getRecordingBooksStringArrayCmd";
    url += "&recorderOfficeId=<%=recordingBook.RecorderOffice.Id.ToString()%>";       
    url += "&recordingActTypeCategoryId=" + getElement("cboAnnotationCategory").value; 

    invokeAjaxComboItemsLoader(url, getElement("cboAnnotationBook"))
  }
    
  function validateRecordingStep1() {
    <% if (!recording.IsNew) { %>
      if (existsElement("btnSaveRecording") && getElement("btnSaveRecording").disabled) {
        return true;
      }
    <% } %>
    if (getElement('cboRecordingType').value == '') {
      alert("Necesito se proporcione el tipo de inscripci�n.");
      return false;
    }
    if (getElement('txtRecordingNumber').value == '') {
      alert("Necesito se proporcione el n�mero de inscripci�n.");
      return false;
    }
    if (!isNumeric(getElement('txtRecordingNumber'))) {
      alert("No reconozco el n�mero de inscripci�n proporcionado.");
      return false;
    }
    if (Number(getElement('txtRecordingNumber').value) <= 0) {
      alert("Los n�meros de inscripci�n deben ser mayores a cero.");
      return false;
    }
    if (getElement('txtImageStartIndex').value == '') {
      alert("Requiero se proporcione el n�mero de imagen en donde comienza el documento.");
      return false;
    }
    if (!isNumericValue(getElement('txtImageStartIndex').value)) {
      alert("No reconozco el n�mero de imagen donde comienza el documento.");
      return false;
    }
    if (getElement('txtImageEndIndex').value == '') {
      alert("Requiero se proporcione el n�mero de imagen en donde termina el documento.");
      return false;
    }
    if (!isNumericValue(getElement('txtImageEndIndex').value)) {
      alert("No reconozco el n�mero de imagen donde termina el documento.");
      return false;
    }
    if (getElement('txtImageStartIndex').value <= 0) {
      alert("La imagen inicial debe ser mayor a cero.");
      return false;
    }
    if (Number(getElement('txtImageStartIndex').value) > Number(getElement('txtImageEndIndex').value)) {
      alert("El n�mero de imagen donde comienza la inscripci�n no pude ser mayor al n�mero de imagen donde termina la misma.");
      return false;
    }
    if (getElement('txtPresentationDate').value != '') {
      if (!isDate(getElement('txtPresentationDate'))) {
        alert("No reconozco la fecha de presentaci�n de la inscripci�n.");
        return false;
      }
      if (isNoLabourDate(getElement('txtPresentationDate').value)) {
        if (!confirm("La fecha de presentaci�n de la inscripci�n est� marcada como un d�a no laborable.\n\n�La fecha de presentaci�n est� correcta?")) {
          return false;
        }
      }
    }
    if (getElement('txtPresentationTime').value != '') {
      if (!isHour(getElement("txtPresentationTime"))) {
        alert("No reconozco la hora en la que se present� la inscripci�n.");
        return;
      } else {
        getElement("txtPresentationTime").value = formatAsTime(getElement("txtPresentationTime").value);
      }
    }
    if (getElement('txtAuthorizationDate').value != '') {
      if (!isDate(getElement('txtAuthorizationDate'))) {
        alert("No reconozco la fecha de autorizaci�n de la inscripci�n.");
        return false;
      }
      if (isNoLabourDate(getElement('txtAuthorizationDate').value)) {
        if (!confirm("La fecha de autorizaci�n de la inscripci�n est� marcada como un d�a no laborable.\n\n�La fecha de autorizaci�n est� correcta?")) {
          return false;
        }
      }
    }
    if (getElement('txtPresentationDate').value != '' && getElement('txtAuthorizationDate').value != '') {		
      if (!isValidDatePeriod(getElement('txtPresentationDate').value, getElement('txtAuthorizationDate').value)) {
        alert("La fecha de autorizaci�n de la inscripci�n no puede ser anterior a su fecha de presentaci�n.");
        return false;
      }
      if (daysBetween(getElement('txtPresentationDate').value, getElement('txtAuthorizationDate').value) > 30) {
        if (!confirm("Transcurrieron m�s de 30 d�as entre la fecha de presentaci�n y la fecha de autorizaci�n de la inscripci�n.\n\n�Las fechas de la inscripci�n est�n correctas?")) {
          return false;
        }
      }		  
    }
    if (getElement('cboAuthorizedBy').value == '') {
      alert("Necesito se seleccione de la lista al C. Oficial Registrador que autoriz� esta inscripci�n.");
      return false;
    }
    <% if (RecordingPayment.UseInBatchRegistering) { %>
      if (!<%=oRecordingPaymentEditorControl.ClientID%>_validate()) {
        return false;
      }
    <% } %>
    if (!<%=oRecordingDocumentEditor.ClientID%>_validate(getElement("txtPresentationDate").value)) {
      return false;
    }
    var overlappingRecordings = getOverlappingRecordingsCount(<%=recordingBook.Id%>, <%=recording.Id%>, getElement("txtImageStartIndex").value, getElement("txtImageEndIndex").value);
    if (overlappingRecordings > 0) {
      var sMsg = "Posible traslape de im�genes de inscripciones.\n\nEn las im�genes comprendidas en el rango de la " + getElement('txtImageStartIndex').value;
      if (overlappingRecordings == 1) {
        sMsg += " a la " + getElement('txtImageEndIndex').value + ", existe otra inscripci�n.\n\n�Las im�genes inicial y final son correctas?";
      } else { 
        sMsg += " a la " + getElement('txtImageEndIndex').value + ", existen otras " + overlappingRecordings + " inscripciones.\n\n�Es esto correcto?";
      }
      if (!confirm(sMsg)) {
        return false;
      }
    }
    return true;
  }
  
  function validateRecordingStep2() {
    <% if (!recording.IsNew) { %>
      if (existsElement("btnSaveRecording") && getElement("btnSaveRecording").disabled) {
        return true;
      }
    <% } %>
    if (getElement('txtPresentationDate').value == '') {
      alert("Requiero la fecha de presentaci�n de la inscripci�n.");
      return false;
    }
    if (getElement("txtPresentationTime").value == '') {
      alert("Requiero la hora de presentaci�n de la inscripci�n.");
      return;
    }
    if (getElement('txtAuthorizationDate').value == '') {
      alert("Requiero la fecha de autorizaci�n de la inscripci�n.");
      return false;
    }
    return true;
  }
    
  function validateRecordingAct() {
    if (getElement('cboRecordingActType').value == '') {
      alert("Necesito se seleccione de la lista el tipo de acto jur�dico.");
      return false;
    }
    if (getElement('cboProperty').value == '') {
      alert("Necesito se seleccione de la lista el predio sobre el que aplicar� el acto jur�dico.");
      return false;
    }
    if (getElement('cboProperty').value == '-1' && getElement('cboAnotherProperty').value == "") {
      alert("Necesito se seleccione de la lista el predio ya registrado o inscrito sobre el que aplicar� el acto jur�dico.");
      return false;
    }
    return true;
  }
    
  function validateAnnotationStep1() {
    if (getElement('cboAnnotation').value == '') {
      alert("Necesito se seleccione de la lista el tipo de anotaci�n.");
      return false;
    }
    if (getElement('cboAnnotationBook').value == '') {
      alert("Requiero se seleccione el libro al que hace referencia la anotaci�n.");
      return false;
    }
    if (getElement('cboAnnotationProperty').value == '') {
      alert("Necesito se seleccione el predio al que hace referencia la anotaci�n.");
      return false;
    }
    if (getElement('cboAnnotationDocumentType').value == '') {
      alert("Necesito se proporcione el tipo de documento de la anotaci�n.");
      return false;
    }
    if (getElement('txtAnnotationNumber').value == '') {
      alert("Necesito se proporcione el n�mero de inscripci�n de la anotaci�n.");
      return false;
    }
    if (!isNumeric(getElement('txtAnnotationNumber'))) {
      alert("No reconozco el n�mero de inscripci�n de la anotaci�n proporcionado.");
      return false;
    }
    if (getElement('txtAnnotationImageStartIndex').value == '') {
      alert("Requiero se proporcione el n�mero de imagen en donde comienza la anotaci�n que se desea agregar.");
      return false;
    }
    if (getElement('txtAnnotationImageEndIndex').value == '') {
      alert("Requiero se proporcione el n�mero de imagen en donde termina la anotaci�n que se desea agregar.");
      return false;
    }		
    if (!isNumericValue(getElement('txtAnnotationImageStartIndex').value)) {
      alert("No reconozco el n�mero de imagen donde comienza la anotaci�n.");
      return false;
    }
    if (!isNumericValue(getElement('txtAnnotationImageEndIndex').value)) {
      alert("No reconozco el n�mero de imagen donde termina la anotaci�n.");
      return false;
    }
    if (Number(getElement('txtAnnotationImageStartIndex').value) > Number(getElement('txtAnnotationImageEndIndex').value)) {
      alert("El n�mero de imagen donde comienza la anotaci�n no pude ser mayor al n�mero de imagen donde termina.");
      return false;
    }
    if (!isEmpty(getElement('txtAnnotationPresentationDate'))) {
      if (!isDate(getElement('txtAnnotationPresentationDate'))) {
        alert("No reconozco la fecha de presentaci�n de la anotaci�n.");
        return false;
      }
      if (isNoLabourDate(getElement('txtAnnotationPresentationDate').value)) {
        if (!confirm("La fecha de presentaci�n de la anotaci�n est� marcada como un d�a no laborable.\n\n�La fecha de presentaci�n de la anotaci�n est� correcta?")) {
          return false;
        }			
      }
      if (!isValidDatePeriod(getElement('txtPresentationDate').value, getElement('txtAnnotationPresentationDate').value)) {
        alert("La fecha de presentaci�n de la anotaci�n no puede ser anterior a la fecha de presentaci�n de la inscripci�n del predio.");
        return false;
      }
    }
    if (getElement('txtAnnotationPresentationTime').value != '') {
      if (!isHour(getElement("txtAnnotationPresentationTime"))) {
        alert("No reconozco la hora en la que se present� la anotaci�n.");
        return;
      } else {
        getElement("txtAnnotationPresentationTime").value = formatAsTime(getElement("txtAnnotationPresentationTime").value);
      }
    }
    if (!isEmpty(getElement('txtAnnotationAuthorizationDate'))) {
      if (!isDate(getElement('txtAnnotationAuthorizationDate'))) {
        alert("No reconozco la fecha de autorizaci�n de la anotaci�n.");
        return false;
      }
      if (isNoLabourDate(getElement('txtAnnotationAuthorizationDate').value)) {
        if (!confirm("La fecha de autorizaci�n de la anotaci�n est� marcada como un d�a no laborable.\n\n�La fecha de autorizaci�n de la anotaci�n est� correcta?")) {
          return false;
        }
      }
      if (!isValidDatePeriod(getElement('txtAuthorizationDate').value, getElement('txtAnnotationAuthorizationDate').value)) {
        alert("La fecha de autorizaci�n de la anotaci�n no puede ser anterior a la fecha de autorizaci�n de la inscripci�n del predio.");
        return false;
      }			
    }		
    if (!isEmpty(getElement('txtAnnotationPresentationDate')) && !isEmpty(getElement('txtAnnotationAuthorizationDate'))) {
      if (!isValidDatePeriod(getElement('txtAnnotationPresentationDate').value, getElement('txtAnnotationAuthorizationDate').value)) {
        alert("La fecha de autorizaci�n de la anotaci�n no puede ser anterior a su fecha de presentaci�n.");
        return false;
      }		  
      if (daysBetween(getElement('txtAnnotationPresentationDate').value, getElement('txtAnnotationAuthorizationDate').value) > 30) {
        if (!confirm("Transcurrieron m�s de 30 d�as entre la fecha de presentaci�n y la fecha de autorizaci�n de la anotaci�n.\n\n�Las fechas de la anotaci�n est�n correctas?")) {
          return false;
        }
      }
    }
    if (getElement('cboAnnotationAuthorizedBy').value == '') {
      alert("Necesito se seleccione de la lista al C. Oficial Registrador que autoriz� la anotaci�n.");
      return false;
    }
    <% if (RecordingPayment.UseInBatchRegistering) { %>
      if (!<%=oAnnotationPaymentEditorControl.ClientID%>_validate()) {
        return false;
      }
    <% } %>
    if (!<%=oAnnotationDocumentEditor.ClientID%>_validate(getElement("txtAnnotationPresentationDate").value)) {
      return false;
    }
    var overlappingRecordings = getOverlappingRecordingsCount(getElement("cboAnnotationBook").value, 0, getElement("txtAnnotationImageStartIndex").value, getElement("txtAnnotationImageEndIndex").value);
    if (overlappingRecordings > 0) {
      var sMsg = "Posible traslape de im�genes de anotaciones.\n\nEn las im�genes comprendidas en el rango de la " + getElement('txtAnnotationImageStartIndex').value;
      if (overlappingRecordings == 1) {
        sMsg += " a la " + getElement('txtAnnotationImageEndIndex').value + ", existe otra anotaci�n o limitaci�n.\n\n�Las im�genes inicial y final son correctas?";
      } else { 
        sMsg += " a la " + getElement('txtAnnotationImageEndIndex').value + ", existen otras " + overlappingRecordings + " anotaciones o limitaciones.\n\n�Es esto correcto?";
      }
      if (!confirm(sMsg)) {
        return false;
      }
    }
    return true;
  }

  function validateAnnotationStep2() {
    if (getElement('txtAnnotationPresentationDate').value == '') {
      alert("Requiero la fecha de presentaci�n de la anotaci�n que se desea agregar.");
      return false;
    }
    if (getElement("txtAnnotationPresentationTime").value == '') {
      alert("Requiero la hora de presentaci�n de la anotaci�n que se desea agregar.");
      return false;
    }
    if (getElement('txtAnnotationAuthorizationDate').value == '') {
      alert("Requiero la fecha de autorizaci�n de la anotaci�n que se desea agregar.");
      return false;
    }
    return true;
  }
    
  function moveToImage(position) {
    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getDirectoryImageURL";
    var newPosition = 0;
    switch (position) {
      case "first":
        ajaxURL += "&position=" + position;
        newPosition = 0;
        break;
      case "previous":
        ajaxURL += "&position=" + position;
        newPosition = Math.max(Number(getElement("hdnCurrentImagePosition").value) - 1, 0);
        break;					
      case "next":
        ajaxURL += "&position=" + position;
        newPosition = Math.min(Number(getElement("hdnCurrentImagePosition").value) + 1, selectedBookImageCount() - 1);
        break;
      case "last":
        ajaxURL += "&position=" + position;
        newPosition = selectedBookImageCount() - 1;
        break;
      case "refresh":
        ajaxURL += "&position=" + position;
        newPosition = getRecordingStartImageIndex() - 1;
        break;
      default:
        alert("No reconozco la posici�n de la imagen que se desea desplegar.");
        return;
    }
    if (getElement('cboRecordingBookSelector').value.length == 0) {
      return;
    } else if (getElement('cboRecordingBookSelector').selectedIndex == 0) {
      ajaxURL += "&directoryId=<%=recordingBook.ImagingFilesFolder.Id%>";
    } else if (getElement("cboRecordingBookSelector").value.substring(0, 1) != "&") {
      ajaxURL += "&recordingId=" + getElement('cboRecordingBookSelector').value;
    } else if (getElement("cboRecordingBookSelector").value.substring(0, 1) == "&") {
      ajaxURL += getElement("cboRecordingBookSelector").value;
    } else {
      return;
    }
    ajaxURL += "&currentPosition=" + getElement("hdnCurrentImagePosition").value;

    var result = invokeAjaxMethod(false, ajaxURL, null);
    getElement("imgCurrent").src = result;
    getElement("hdnCurrentImagePosition").value = newPosition;
    setPageTitle();
  }

  function doZoom() {
    var oImage = getElement("imgCurrent");
    
    var width = 1336;
    var height = 994;
    var zoomLevel = Number(getElement('cboZoomLevel').value);
    oImage.setAttribute('width', Number(width) * zoomLevel);
    oImage.setAttribute('height', Number(height) * zoomLevel);
  }  
    
  function setPageTitle() {
    var s = String();    
    var imageXOfY = getCurrentImage() + " de " + selectedBookImageCount();
    setInnerText(getElement("spanPageTitle"), '<%=recording.IsNew ? "Nueva inscripci�n" : "Inscripci�n " + recording.Number%> en <%=recordingBook.FullName%>');
    if (getElement("cboRecordingBookSelector").value.length == 0) {
      // no-op
    } else if (getElement("cboRecordingBookSelector").selectedIndex == 0) {
      setInnerText(getElement("spanCurrentImage"), "Imagen " + imageXOfY);
    } else if (getElement("cboRecordingBookSelector").value.substring(0, 1) != "&") {
      setInnerText(getElement("spanCurrentImage"), "Imagen " + imageXOfY + " de la anotaci�n " + getComboOptionText(getElement("cboRecordingBookSelector")));
    } else if (getElement("cboRecordingBookSelector").value.substring(0, 1) == "&") {
      setInnerText(getElement("spanCurrentImage"), "Imagen " + imageXOfY + " del ap�ndice " + getComboOptionText(getElement("cboRecordingBookSelector")));
    }
  }

  function getCurrentImage() {
    return Number(Number(getElement("hdnCurrentImagePosition").value) + 1);
  }

  function pickCurrentImage(controlName) {
    getElement(controlName).value = getCurrentImage();
  }
  
  function selectedBookImageCount() {
    if (arguments.length == 1) {
      return <%=recordingBook.ImagingFilesFolder.FilesCount.ToString()%>;
    }

    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getRecordingBookImageCountCmd";

    if (getElement('cboRecordingBookSelector').value.substring(0,1) == "&") {
      ajaxURL += getElement('cboRecordingBookSelector').value;
    } else if (getElement('cboRecordingBookSelector').value > 0) {
      ajaxURL += "&recordingId=" + getElement('cboRecordingBookSelector').value;
    } else {
      ajaxURL += "&recordingBookId=<%=recordingBook.Id%>";
    }

    var result = invokeAjaxMethod(false, ajaxURL, null);

    return Number(result);
  }

  function getRecordingStartImageIndex() {
    if (getElement('cboRecordingBookSelector').value.length == 0) {
      return 1;
    }
    if (getElement('cboRecordingBookSelector').value.substring(0, 1) == "&") {
      return 1;
    } else {
      var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getRecordingStartImageIndexCmd";
      ajaxURL += "&recordingId=" + getElement('cboRecordingBookSelector').value;

      var result = invokeAjaxMethod(false, ajaxURL, null);

      return Number(result);
    }
  }

  function gotoImage() {
    if (getElement("txtGoToImage").value.length == 0) {
      alert("Necesito conocer el n�mero de imagen que se desea visualizar.");
      return false;
    }
    if (!isNumeric(getElement("txtGoToImage"))) {
      alert("No reconozco el n�mero de imagen proporcionado.");
      return false;
    }
    if (Number(getElement("txtGoToImage").value) <= 0) {
      alert("El n�mero de imagen que se desea visualizar debe ser positivo.");
      return false;
    }
    var imageCount = selectedBookImageCount();
    if (Number(getElement("txtGoToImage").value) > imageCount) {
      alert("El libro seleccionado s�lo contiene " + imageCount + " im�genes.");
      return false;
    }
    
    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getDirectoryImageURL";
    var newPosition = Number(getElement("txtGoToImage").value) -  1;
    ajaxURL += "&position=" + newPosition;
    ajaxURL += "&directoryId=<%=recordingBook.ImagingFilesFolder.Id%>";
    ajaxURL += "&currentPosition=" + getElement("hdnCurrentImagePosition").value;
    var result = invokeAjaxMethod(false, ajaxURL, null);
    getElement("imgCurrent").src = result;
    getElement("hdnCurrentImagePosition").value = newPosition;
    setPageTitle();

    return true;
  }

  function gotoRecording() {
    if (getElement("txtGoToRecording").value.length == 0) {
      alert("Necesito conocer el n�mero de inscripci�n que se desea visualizar.");
      return false;
    }
    if (!isNumeric(getElement("txtGoToRecording"))) {
      alert("No reconozco el n�mero de inscripci�n proporcionado.");
      return false;
    }
    if (Number(getElement("txtGoToRecording").value) <= 0) {
      alert("No reconozco el n�mero de inscripci�n que se desea visualizar.");
      return false;
    }
    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getRecordingIdCmd";
    ajaxURL += "&recordingBookId=<%=recordingBook.Id%>";	  
    ajaxURL += "&number=" + getElement("txtGoToRecording").value;
    ajaxURL += "&useBisNumberTag=false";
    
    var result = invokeAjaxMethod(false, ajaxURL, null);
    if (Number(result) != 0) {
      sendPageCommand("gotoRecording", "id=" + result);
      return;
    } else {
      alert("No ha sido registrada ninguna inscripci�n con el n�mero " + getElement("txtGoToRecording").value + " en este libro.");
      return;    
    }
  }

  function refreshRecordingViewer() {
    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getRecordingsViewerPageCmd";
    ajaxURL += "&recordingBookId=<%=recordingBook.Id%>";
    ajaxURL += "&page=" + getElement("cboRecordingViewerPage").value;
    ajaxURL += "&itemsPerPage=<%=recordingsPerViewerPage%>";
    
    var result = invokeAjaxMethod(false, ajaxURL, null);
    getElement("tblRecordingsViewer").outerHTML = result;
    return;
  }

  function getOverlappingRecordingsCount(recordingBookId, recordingId, imageStartIndex, imageEndIndex) {
    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getOverlappingRecordingsCountCmd";
    ajaxURL += "&recordingBookId=" + recordingBookId;
    ajaxURL += "&recordingId=" + recordingId;		
    ajaxURL += "&imageStartIndex=" + imageStartIndex;
    ajaxURL += "&imageEndIndex=" + imageEndIndex;

    var result = invokeAjaxMethod(false, ajaxURL, null);

    return Number(result);
  }

  function getRecordingBookImageCount(recordingBookId) {
    var ajaxURL = "../ajax/land.registration.system.data.aspx?commandName=getRecordingBookImageCountCmd";
    ajaxURL += "&recordingBookId=" + recordingBookId;

    var result = invokeAjaxMethod(false, ajaxURL, null);

    return Number(result);
  }

  function showRecordingForEdition(showEditorFlag) {
    if (showEditorFlag) {
      getElement("btnEditRecording").value = "Descartar los cambios";
      getElement("btnDeleteRecording").disabled = false;
      getElement("btnSaveRecording").disabled = false;
      disableControls(getElement("tblRecording"), false);
      <%=oRecordingDocumentEditor.ClientID%>_disabledControl(false);
      getElement("txtObservations").disabled = false;
    } else if (getElement("btnEditRecording").value == "Descartar los cambios") {
      doOperation("refreshRecording");
    } else {
      getElement("btnEditRecording").value = "Editar esta inscripci�n";
      getElement("btnDeleteRecording").disabled = true;
      getElement("btnSaveRecording").disabled = true;
      disableControls(getElement("tblRecording"), true);
      <%=oRecordingDocumentEditor.ClientID%>_disabledControl(true);
      getElement("txtObservations").disabled = true;
    }
  }

  function onclick_editRecordingForEdition() {
    if (getElement("btnEditRecording").value == "Editar esta inscripci�n") {
      showRecordingForEdition(false);
      showRecordingForEdition(true);
    } else {
      showRecordingForEdition(false);
    }
  }

  function showAdditionalImage() {
    if (getElement('cboAnnotationBook').value == '') {
      alert("Requiero se seleccione primero el libro de referencia.");
      return;
    }
    var gotoImage = Number();
    if (getElement("txtAnnotationImageEndIndex").value != '') {
      gotoImage = Number(getElement("txtAnnotationImageEndIndex").value);
    } else if (getElement("txtAnnotationImageStartIndex").value != '') {
      gotoImage = Number(getElement("txtAnnotationImageStartIndex").value);
    } else {
      gotoImage = 1;
    }
    var recordingBookImageCount = 0;
    
    if (gotoImage > 0) {
      recordingBookImageCount = getRecordingBookImageCount(getElement('cboAnnotationBook').value);
    }
    if (gotoImage > recordingBookImageCount) {
      alert("El libro " + getComboOptionText(getElement('cboAnnotationBook')) + " contiene s�lo " + recordingBookImageCount + " im�genes.");
      return false;
    }
    var source = "directory.image.viewer.aspx?";
    source += "id=" + getElement('cboAnnotationBook').value;
    source += "&gotoImage=" + gotoImage;
    createNewWindow(source);
  }
  
  function showAnnotationsEditor() {
    <% if (recording.RecordingActs.Count == 0) { %>
      alert("Para poder anexar una anotaci�n o limitaci�n, requiero que la inscripci�n contenga al menos un acto jur�dico traslativo de dominio.");
      return;
    <% } %>
    if (getElement("divAnnotationEditorRow0").style.display == 'inline') {
      getElement("divAnnotationEditorRow0").style.display = 'none';
      getElement("divAnnotationEditorRow1").style.display = 'none';
      getElement("divAnnotationEditorRow2").style.display = 'none';
      getElement("divAnnotationEditorRow3").style.display = 'none';
      getElement("divAnnotationEditorRow4").style.display = 'none';
      getElement("divAnnotationEditorRow4bis").style.display = 'none';  
      getElement("divAnnotationEditorRow5").style.display = 'none';
      getElement("divAnnotationEditorRow6").style.display = 'none';			
      
    } else {
      getElement("divAnnotationEditorRow0").style.display = 'inline';
      getElement("divAnnotationEditorRow1").style.display = 'inline';
      getElement("divAnnotationEditorRow2").style.display = 'inline';
      getElement("divAnnotationEditorRow3").style.display = 'inline';
      getElement("divAnnotationEditorRow4").style.display = 'inline';
      getElement("divAnnotationEditorRow4bis").style.display = 'inline';
      getElement("divAnnotationEditorRow5").style.display = 'inline';
      getElement("divAnnotationEditorRow6").style.display = 'inline';			
    }
  }	
  
  function saveRecording() {
    if (getElement("cboStatus").value == "<%=(char) Empiria.Government.LandRegistration.RecordingStatus.Obsolete%>") {
      return registerAsObsoleteRecording();
    } else if (getElement("cboStatus").value == "<%= (char) Empiria.Government.LandRegistration.RecordingStatus.NoLegible%>") {
      return registerAsNoLegibleRecording();
    } else if (getElement("cboStatus").value == "<%=(char) Empiria.Government.LandRegistration.RecordingStatus.Pending%>") {
      return registerAsPendingRecording();		
    } else if (getElement("cboStatus").value == "<%= (char) Empiria.Government.LandRegistration.RecordingStatus.Incomplete%>") {
      return registerAsIncompleteRecording(false);
    }
  }
  
  function getAnnotationDataForm() {
    var sMsg = "";
    
    sMsg += "Libro:\t\t<%=recordingBook.FullName%>\n";
    sMsg += "Inscripci�n:\t" + getElement('txtRecordingNumber').value + "\n\n";
    sMsg += getComboOptionText(getElement('cboAnnotation')).toUpperCase() + "\n";
    sMsg += "Inscrita en:\t" + getComboOptionText(getElement('cboAnnotationBook')) + "\n";
    sMsg += "N�mero:\t\t" + getElement('txtAnnotationNumber').value;		
    if (getElement('txtAnnotationImageStartIndex').value != '1' && getElement('txtAnnotationImageEndIndex').value != '1') {
      sMsg += ", ubicada de la imagen " + getElement('txtAnnotationImageStartIndex').value + " a la " + getElement('txtAnnotationImageEndIndex').value + "\n";
    }  else {
      sMsg += ", ubicada en una imagen no determinada.\n";
    }
    if (getElement('txtAnnotationPresentationDate').value.length != 0) {
      sMsg += "Presentaci�n:\t" + "El d�a " + getElement('txtAnnotationPresentationDate').value + " a las " + getElement('txtAnnotationPresentationDate').value + "\n";
    } else {
      sMsg += "Presentaci�n:\t" + "No determinada\n";
    }
    if (getElement('txtAnnotationAuthorizationDate').value.length != 0) {
      sMsg += "Autorizaci�n:\t" + "El d�a " + getElement('txtAnnotationAuthorizationDate').value + "\n";
    } else {
      sMsg += "Autorizaci�n:\t" + "No determinada\n";
    }
    if (getElement('cboAnnotationAuthorizedBy').value.length != 0) {
      sMsg += "C.Registrador:\t" + "Lic. " + getComboOptionText(getElement('cboAnnotationAuthorizedBy')) + "\n\n";
    } else {
      sMsg += "C.Registrador:\t" + "No determinado\n\n";
    }
    return sMsg;
  }

  function getRecordingDataForm() {
    var sMsg = "";
    
    sMsg += "Libro:\t\t<%=recordingBook.FullName%>\n";
    sMsg += "Inscripci�n:\t" + getElement('txtRecordingNumber').value + "\n";
    sMsg += "De la imagen:\t" + getElement('txtImageStartIndex').value + "\n";
    sMsg += "A la imagen:\t" + getElement('txtImageEndIndex').value + "\n\n";
    if (getElement('txtPresentationDate').value.length != 0) {
      sMsg += "Presentaci�n:\t" + "El d�a " + getElement('txtPresentationDate').value + " a las " + getElement('txtPresentationTime').value + "\n";
    } else {
      sMsg += "Presentaci�n:\t" + "No determinada\n";
    }
    if (getElement('txtAuthorizationDate').value.length != 0) {
      sMsg += "Autorizaci�n:\t" + "El d�a " + getElement('txtAuthorizationDate').value + "\n";
    } else {
      sMsg += "Autorizaci�n:\t" + "No determinada\n";
    }
    if (getElement('cboAuthorizedBy').value.length != 0) {
      sMsg += "C.Registrador:\t" + "Lic. " + getComboOptionText(getElement('cboAuthorizedBy')) + "\n\n";
    } else {
      sMsg += "C.Registrador:\t" + "No determinado\n\n";
    }
    return sMsg;
  }

//  function disableRecordingEditor() {
//    getElement("rowNoVigentOrIlegibleButtons").style.display = 'none';
//    getElement("rowEditButtons").style.display = 'inline';
//  	getElement("btnEditRecording").value = "Editar esta inscripci�n";
//		getElement("btnDeleteRecording").disabled = true;
//		getElement("btnSaveRecording").disabled = true;
//    disableControls(getElement("tblRecording"), true);
//    <%=oRecordingDocumentEditor.ClientID%>_disabledControl(true);
//    getElement("txtObservations").disabled = true;
//  }

  function window_onload() {
    setWorkplace2();
    setPageTitle();
    <% if (recording.IsNew) { %>
      getElement("rowNoVigentOrIlegibleButtons").style.display = 'inline';
      getElement("rowEditButtons").style.display = 'none';
      showRecordingForEdition(true);
    <% } else { %>
      getElement("rowNoVigentOrIlegibleButtons").style.display = 'none';
      getElement("rowEditButtons").style.display = 'inline';
      showRecordingForEdition(false);
    <% } %>
  }

  function setWorkplace2() {
    resizeWorkplace2();
    addEvent(window, 'resize', resizeWorkplace2);
    setObjectEvents();
    window.defaultStatus = '';
  }

  function resizeWorkplace2() {
    var divBody = getElement('divBody');
    var divHeader = getElement('divHeader');
    var divContent = getElement('divContent');
    var divImageContainer = getElement('divImageContainer');

    var height = document.documentElement.offsetHeight - divHeader.offsetHeight - 0;
    var width = document.documentElement.offsetWidth;
    if (height > 78) {
      divBody.style.height = height;
      divContent.style.height = height - 18;
      divImageContainer.style.height = height - 78;
    }
    if (width > 28) {
      divContent.style.width = width - 28;
    }
    if (((width - 700) - 38) > 700) {
      divImageContainer.style.width = (width - 700) - 38;
    } else {
      divImageContainer.style.width = 672;
    }
  }

  function window_onresize() {
    ifraItemEditor_onresize();
    window_onscroll();
  }

  function window_onscroll() {
    var documentHeight = getElement("divDocumentViewer").offsetHeight;
    var scrollHeight = getElement("divContent").scrollTop;
    //var oBody = getElement("divDocumentViewer");
    //getElement('divImageViewer').style.top = Math.min(scrollHeight, documentHeight - scrollHeight) + "px";

    var newHeight = Math.min(documentHeight - scrollHeight, scrollHeight);

    if (newHeight <= 0) {
      getElement('divImageViewer').style.top = 0;
    } else {
      getElement('divImageViewer').style.top = newHeight;
    }
  }

  function ifraItemEditor_onresize() {
    var oFrame = getElement("ifraItemEditor");
    var oBody = oFrame.document.body;
    
    //var newHeight = oBody.scrollHeight + (oBody.offsetHeight - oBody.clientHeight);
    var newHeight = oBody.scrollHeight + oBody.clientHeight;

    if (newHeight <= 800) {
      oFrame.style.height = 800;
    } else {
      oFrame.style.height = newHeight;
    }
    //oFrame.style.width = oBody.scrollWidth + (oBody.offsetWidth - oBody.clientWidth);
  }

  addEvent(window, 'load', window_onload);
  addEvent(window, 'resize', window_onresize);
  addEvent(getElement('divContent'), 'scroll', window_onscroll);
  addEvent(getElement("ifraItemEditor"), 'resize', ifraItemEditor_onresize);

  /* ]]> */
  </script>
</html>