<%@ Import Namespace="Empiria.Presentation" %>
<%@ Import Namespace="Empiria.Government.LandRegistration" %>
<%@ Import Namespace="Empiria.Government.LandRegistration.UI" %>

<%# ((int) DataBinder.Eval(Container, "ItemIndex")) == 0 ? "<tbody>" : String.Empty %>
<tr class="<%# ((int) DataBinder.Eval(Container, "ItemIndex") % 2 == 0 ? String.Empty  : "oddDataRow") %>" onmouseover="dataGridRowSelect(this, true);" onmouseout="dataGridRowSelect(this, false);">
	<td style="white-space:nowrap;">
		<table class="ghostTable">
			<tr><td rowspan="5"><a href="javascript:doOperation('viewRecordingBook', <%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>)"><img src="../themes/default/app.icons/library.gif" alt='' title="Muestra las im�genes de este libro registral" style='margin-right:20px' /></a></td>
					<td colspan="6" style='width:100%;height:22px'><a id="ancRecordingBook<%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>" class="detailsLinkTitle" href="javascript:doOperation('viewRecordingBook', <%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>)" title="Muestra las im�genes de este libro registral"><%#DataBinder.Eval(Container, "DataItem.RecordingBookFullName")%></a></td></tr>
			<tr><td style="width:20px">Inscripciones:&nbsp;</td><td><span id="ancRecordingsControlCount<%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>" class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.RecordingsControlCount")).ToString("N0")%></span>&nbsp; &nbsp; &nbsp;</td><td>Vigentes:</td><td><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.ActiveRecordingsCount")).ToString("N0")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span></td><td>Tipo:</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.RecordingsClassName")%>&nbsp;</span></td></tr>
			<tr><td style="width:20px">Completas:</td><td><span id="ancCurrentCapturedRecordingsCount<%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>" class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.RegisteredRecordingsCount")).ToString("N0")%></span>&nbsp; &nbsp; &nbsp;</td><td>No vigentes: &nbsp;</td><td><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.ObsoleteRecordingsCount")).ToString("N0")%></span></td><td style="width:20px">Im�genes:&nbsp;</td><td><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.FilesCount")).ToString("N0")%> (<%#((int)DataBinder.Eval(Container, "DataItem.FilesTotalSize") / 1024).ToString("N0")%> MB)</span></td></tr>
			<tr><td style="width:20px">Incompletas:</td><td><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.IncompleteRecordingsCount")).ToString("N0")%></span></td><td>No legibles:</td><td><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.NoLegibleRecordingsCount")).ToString("N0")%></span>&nbsp; &nbsp; &nbsp;</td><td style="width:20px">Estado:&nbsp;&nbsp;</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.RecordingBookStatusName")%></span>&nbsp;&nbsp;</td></tr>
			<tr><td style="white-space:nowrap">Por registrar:</td><td><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.LeftCapturedRecordingsCount")).ToString("N0")%>&nbsp; &nbsp; &nbsp;</span></td><td>Pendientes:&nbsp;</td><td><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.PendingRecordingsCount")).ToString("N0")%></span></td><td style="width:20px">Avance:&nbsp;&nbsp;</td><td><span class='boldItem'><%# Convert.ToDecimal(DataBinder.Eval(Container, "DataItem.CapturedRecordingsPercentage")).ToString("P2")%></span>&nbsp;&nbsp;</td></tr>
		</table>
	</td>
	<td style="white-space:nowrap;">
	  <img src="../themes/default/textures/pixel.gif" height="20px" width="1px" alt="" />
	  <br />
		<table class="ghostTable">
		  <tr><td>Digitalizado por:</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.ImagesCapturedBy")%></span></td></tr>
		  <tr><td>Cortado por:</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.ImagesReviewedBy")%></span></td></tr>
		  <tr><td>Analista asignado: &nbsp;</td><td><span class='boldItem'><%#DataBinder.Eval(Container, "DataItem.AssignedTo")%></span></td></tr>
		  <tr><td>Rango de fechas: &nbsp;</td>
		      <td><span class='boldItem'>Del <%#((DateTime)DataBinder.Eval(Container, "DataItem.RecordingsControlFirstDate")).ToString("dd/MMM/yyyy")%>
		          al <%#((DateTime)DataBinder.Eval(Container, "DataItem.RecordingsControlLastDate")).ToString("dd/MMM/yyyy")%>		          
		      </span></td>
		  </tr>
    </table>
	</td>
	<td style="white-space:nowrap;width:40%">			
		<br />
		Operaci�n:
		<select id="cboOperation<%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>" class="selectBox" onchange="changePendingBookOperationsUI(<%# DataBinder.Eval(Container, "DataItem.RecordingBookId")%>)" style="width:270px" title="">
			<option value=''>�Qu� debo hacer con este libro registral?</option>
			<option value=''></option>
			<option value='unassignRecordingBook'>Dejar este libro sin analista asignado</option>
			<option value=''></option>			
		  <option value='updateRecordingsControlCount'>Modificar el n�mero de inscripciones</option>
		  <option value='updateRecordingsControlDates'>Modificar el rango de control de fechas</option>
			<%#(int)DataBinder.Eval(Container, "DataItem.LeftCapturedRecordingsCount") == 0 ? "<option value=''></option><option value='sendRecordingBookToQualityControl'>Enviarlo al �rea de control de calidad</option>" : String.Empty%>	
    </select><img class='comboExecuteImage' src="../themes/default/buttons/next.gif" alt=""  title="Ejecuta la operaci�n seleccionada" onclick="doPendingBookOperation(<%# DataBinder.Eval(Container, "DataItem.RecordingBookId")%>)"/> 
    <br />
		<span id="divRecordingBookAnalyst<%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>" style="display:none">
			Analista asignado: <span id="ancAssignedAnalyst<%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>" class='boldItem' style="line-height:28px"><%#DataBinder.Eval(Container, "DataItem.AssignedTo")%></span>	
    </span>
    <span id="divRecordingsControlCount<%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>" style="display:none">
   		<img src="../themes/default/textures/pixel.gif" height="1px" width="27px" alt="" />
			Nuevo n�mero de inscripciones de control para el libro: <input id="txtRecordingsControlCount<%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>" class="textBox" type="text" maxlength="4" style="width:38px" onkeypress="return integerKeyFilter(this);" value="<%#DataBinder.Eval(Container, "DataItem.RecordingsControlCount")%>" />
    </span>
     <span id="divRecordingsControlDates<%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>" style="display:none">
   		  <img src="../themes/default/textures/pixel.gif" height="1px" width="7px" alt="" />
			  Fecha de presentaci�n de la primera inscripci�n: &nbsp;
			  <input type="text" class="textBox" id='txtFromDate<%# DataBinder.Eval(Container, "DataItem.RecordingBookId")%>' value='<%#((DateTime)DataBinder.Eval(Container, "DataItem.RecordingsControlFirstDate")).ToString("dd/MMM/yyyy")%>' style="margin-right:2px;width:64px;" onblur="formatAsDate(this)" title="" value="" /><img id='imgFromDate<%# DataBinder.Eval(Container, "DataItem.RecordingBookId")%>' 
               src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtFromDate<%# DataBinder.Eval(Container, "DataItem.RecordingBookId")%>'), getElement('imgFromDate<%# DataBinder.Eval(Container, "DataItem.RecordingBookId")%>'));" title="Despliega el calendario"  style="padding:0px;margin:0px" alt="" hspace="0" />
			  <br />
   		  <img src="../themes/default/textures/pixel.gif" height="1px" width="20px" alt="" />			  
			  Fecha de autorizaci�n de la �ltima inscripci�n: &nbsp;
        <input type="text" class="textBox" id='txtToDate<%# DataBinder.Eval(Container, "DataItem.RecordingBookId")%>' value='<%#((DateTime)DataBinder.Eval(Container, "DataItem.RecordingsControlLastDate")).ToString("dd/MMM/yyyy")%>' style="margin-right:2px;width:64px;" onblur="formatAsDate(this)" title="" value="" /><img id='imgToDate<%# DataBinder.Eval(Container, "DataItem.RecordingBookId")%>' 
               src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('txtToDate<%# DataBinder.Eval(Container, "DataItem.RecordingBookId")%>'), getElement('imgToDate<%# DataBinder.Eval(Container, "DataItem.RecordingBookId")%>'));" title="Despliega el calendario"  style="padding:0px;margin:0px" alt="" hspace="0" />			  
     </span>
    <span id="divCloseRecordingBook<%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>" style="display:none">
   		<img src="../themes/default/textures/pixel.gif" height="1px" width="46px" alt="" />
			Firma electr�nica de autorizaci�n: <input id="txtCloseAuthorizationSign<%#DataBinder.Eval(Container, "DataItem.RecordingBookId")%>" class="textBox" type="password" maxlength="16" style="width:124px" value="" />
   </span>  
   <br />
	 <textarea id="txtNotes<%# DataBinder.Eval(Container, "DataItem.RecordingBookId")%>" class="textArea" rows="2" style="width:341px"></textarea>     
	</td>
</tr>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).IsLastItem((int) DataBinder.Eval(Container, "ItemIndex")) ? "</tbody>" : String.Empty %>
