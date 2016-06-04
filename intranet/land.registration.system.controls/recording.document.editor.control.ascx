<%@ Control Language="C#" AutoEventWireup="false" Inherits="Empiria.Web.UI.LRS.RecordingDocumentEditorControl" Codebehind="recording.document.editor.control.ascx.cs" %>
<table id="oNotaryRecording" class="editionTable" style="display:none;" runat="server">
    <tr>
    <td>Notaría: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</td>
    <td>
			<select id="cboNotaryDocIssuePlace" class="selectBox" style="width:168px" title="" runat="server" >
			</select>
    </td>
    <td>
      Número:
    </td>
    <td>
			<select id="cboNotaryDocIssueOffice" class="selectBox" style="width:80px" title="" runat="server" >
			</select>
    </td>
    <td>
      Volumen / libro:
    </td>
    <td>
		  <input id="txtNotaryDocBook" type="text" class="textBox" style="width:40px" onkeypress="return integerKeyFilter(this);" 
             title="" maxlength="5"  runat="server" />
    </td>
    <td>
      Escritura:
    </td>
    <td class="lastCell">
    	<input id="txtNotaryDocNumber" name="txtNotaryDocNumber" type="text" class="textBox" style="width:40px" 
			 onkeypress="return integerKeyFilter(this);" title="" maxlength="5"  runat="server" />	
		</td>
  </tr>
</table>
<table id="oTitleRecording" class="editionTable" style="display:none;" runat="server">
    <tr>
    <td>
      Título de propiedad número:
    </td>
    <td><input id="txtPropTitleDocNumber" type="text" class="textBox" style="width:106px" onkeypress="return integerKeyFilter(this);" 
         title="" maxlength="16" runat="server" /></td>
    <td>Expedido por:</td>
    <td class="lastCell">C. 
      <select id="cboPropTitleDocIssuedBy" class="selectBox" style="width:290px" title="" runat="server">
			</select>
    </td>
  </tr>
  <tr>
    <td>Fecha del acta de asamblea:</td>
    <td>
      <input id='txtPropTitleIssueDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
		  <img id='imgPropTitleIssueDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtPropTitleIssueDate.ClientID%>'), getElement('imgPropTitleIssueDate'));" title="Despliega el calendario" alt="" />                    
    </td>
    <td class="lastCell" colspan="2">
      Expedido en:
      <select id="cboPropTitleIssueOffice" class="selectBox" style="width:166px" title="" runat="server">
		  </select>
      Folio:
      <input id="txtPropTitleStartSheet" type="text" class="textBox" style="width:100px" onkeypress="return integerKeyFilter(this);" title="" maxlength="16"  runat="server" />
    </td>
  </tr>
</table>
<table id="oJudicialRecording" class="editionTable" style="display:none;" runat="server">
  <tr>
    <td>
      Ciudad:
    </td>
    <td>
      <select id="cboJudicialDocIssuePlace" class="selectBox" style="width:180px" title="" runat="server">
			</select>
    </td>
    <td>Juzgado:</td>
    <td>
      <select id="cboJudicialDocIssueOffice" class="selectBox" style="width:120px" title="" runat="server">
			</select>
    </td>
    <td class="lastCell">
      Lic.
      <select id="cboJudicialDocIssuedBy" class="selectBox" style="width:206px" title="" runat="server">
			</select>
    </td>
  </tr>
  <tr>
    <td colspan="2">
      Núm de expediente: &nbsp;
      <input id="txtJudicialDocBook" type="text" class="textBox" style="width:114px" title="" maxlength="24"  runat="server" />
    </td>
    <td colspan="2">
      Número de oficio: &nbsp;
      <input id="txtJudicialDocNumber" type="text" class="textBox" style="width:70px" title="" maxlength="16"  runat="server" />
    </td>
    <td class="lastCell">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
      Fecha del oficio:
      <input id='txtJudicialDocIssueDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
		  <img id='imgJudicialDocIssueDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtJudicialDocIssueDate.ClientID%>'), getElement('imgJudicialDocIssueDate'));" title="Despliega el calendario" alt="" />
    </td>
  </tr>
</table>
<table id="oPrivateRecording" class="editionTable" style="display:none;" runat="server">
  <tr>
    <td>
      Ciudad:
    </td>
    <td>
      <select id="cboPrivateDocIssuePlace" class="selectBox" style="width:180px" title="" runat="server">
			</select>
    </td>
    <td>
      Fecha del contrato:
    </td>
    <td>
      <input id='txtPrivateDocIssueDate' type="text" class="textBox" style="width:66px;" onblur="formatAsDate(this)" title="" runat="server" />
		  <img id='imgPrivateDocIssueDate' src="../themes/default/buttons/ellipsis.gif" onclick="return showCalendar(getElement('<%=txtPrivateDocIssueDate.ClientID%>'), getElement('imgPrivateDocIssueDate'));" title="Despliega el calendario" alt="" />
    </td>
    <td>
      &nbsp; &nbsp; &nbsp;Número de contrato:
    </td>
    <td class="lastCell">
      <input id="txtPrivateDocNumber" type="text" class="textBox" style="width:70px" onkeypress="return integerKeyFilter(this);" title="" maxlength="8"  runat="server" />
    </td>
  </tr>
  <tr>
    <td>Certificó:</td>
    <td>
      <select id="cboPrivateDocMainWitnessPosition" class="selectBox" style="width:180px" title="" runat="server">
			</select>
    </td>
    <td class="lastCell" colspan="4">
      C.
      <select id="cboPrivateDocMainWitness" class="selectBox" style="width:394px" title="" runat="server">
			</select>
    </td>
  </tr>
</table>
<script type="text/javascript">
	/* <![CDATA[ */
	
  function <%=this.ClientID%>_validate(presentationDate) {
    if (getElement("<%=oNotaryRecording.ClientID%>").style.display == 'inline') {
      return <%=this.ClientID%>_validateNotaryRecording(presentationDate);
    } else if (getElement("<%=oTitleRecording.ClientID%>").style.display == 'inline') {
      return <%=this.ClientID%>_validateTitleRecording(presentationDate);
    } else if (getElement("<%=oJudicialRecording.ClientID%>").style.display == 'inline') {
      return <%=this.ClientID%>_validateJudicialRecording(presentationDate);
    } else if (getElement("<%=oPrivateRecording.ClientID%>").style.display == 'inline') {
      return <%=this.ClientID%>_validatePrivateRecording(presentationDate);
    } else {
      return true;
    }
  }

  function <%=this.ClientID%>_validateNotaryRecording(presentationDate) {
    if (getElement("<%=cboNotaryDocIssuePlace.ClientID%>").value.length == 0) {
      alert("Requiero se proporcione la ciudad a la que pertenece la\nnotaría donde se efectuó la protocolización.")
      return false;
    }
    if (getElement("<%=cboNotaryDocIssueOffice.ClientID%>").value.length == 0) {
      alert("Requiero se proporcione la notaría donde se efectuó la protocolización.")
      return false;
    }
    if (getElement("<%=txtNotaryDocBook.ClientID%>").value.length == 0) {
      alert("Requiero conocer el número de volumen donde está protocolizada la inscripción.")
      return false;
    }
    if (getElement("<%=txtNotaryDocNumber.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione el número de escritura que le corresponde a esta inscripción.")
      return false;
    }
    return true;
  }

  function <%=this.ClientID%>_validateTitleRecording(presentationDate) {
   if (getElement("<%=txtPropTitleDocNumber.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione el número de título de propiedad.")
      return false;
    }
    if (getElement("<%=cboPropTitleDocIssuedBy.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione el nombre del funcionario que expidió el título de propiedad.")
      return false;
    }
    if (getElement("<%=txtPropTitleIssueDate.ClientID%>").value.length != 0) {
	    if (!isDate(getElement('<%=txtPropTitleIssueDate.ClientID%>'))) {
		    alert("No reconozco la fecha del acta de asamblea.");
		    return false;
		  }
	    if (!isValidDatePeriod(getElement('<%=txtPropTitleIssueDate.ClientID%>').value, presentationDate)) {
		    alert("La fecha del acta de asamblea no puede ser posterior a la fecha de presentación de la inscripción.");
		    return false;
	    }
    } else {
      if (!confirm("No se ha proporcionado la fecha del acta de asamblea.\n\n¿Se desconoce la fecha del acta de asamblea?")) {
        return false;
      }
    }
    if (getElement("<%=cboPropTitleIssueOffice.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione la dependencia en donde estaba inscrita la propiedad.")
      return false;
    }
    if (getElement("<%=txtPropTitleStartSheet.ClientID%>").value.length == 0) {
      alert("Requiero se proporcione el folio de inscripción del predio dentro de la dependencia seleccionada.")
      return false;
    }
    return true;
  }

  function <%=this.ClientID%>_validateJudicialRecording(presentationDate) {
    if (getElement("<%=cboJudicialDocIssuePlace.ClientID%>").value.length == 0) {
      alert("Requiero se proporcione la ciudad a la que pertenece el\njuzgado que envió la orden de registro.")
      return false;
    }
    if (getElement("<%=cboJudicialDocIssueOffice.ClientID%>").value.length == 0) {
      alert("Requiero se seleccione de la lista el juzgado que envió la orden de registro.")
      return false;
    }
    if (getElement("<%=cboJudicialDocIssuedBy.ClientID%>").value.length == 0) {
      alert("Necesito se seleccione el nombre del C. Juez que envió la orden de registro.")
      return false;
    }
    if (getElement("<%=txtJudicialDocBook.ClientID%>").value.length == 0) {
      alert("Requiero conocer el número de expediente del juzgado que envió la orden de registro.")
      return false;
    }
    if (getElement("<%=txtJudicialDocNumber.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione el número de Oficio del juzgado que envió la orden de registro.")
      return false;
    }
    if (getElement("<%=txtJudicialDocIssueDate.ClientID%>").value.length != 0) {
	    if (!isDate(getElement('<%=txtJudicialDocIssueDate.ClientID%>'))) {
		    alert("No reconozco la fecha del Oficio que envió el C. Juez.");
		    return false;
		  }
	    if (!isValidDatePeriod(getElement('<%=txtJudicialDocIssueDate.ClientID%>').value, presentationDate)) {
		    alert("La fecha del Oficio del juzgado no puede ser posterior a la fecha de registro de la inscripción.");
		    return false;
	    }
    } else {
      if (!confirm("No se ha proporcionado la fecha del Oficio que envió el C. Juez.\n\n¿Se desconoce la fecha del Oficio?")) {
        return false;
      }
    }
    return true;
  }

  function <%=this.ClientID%>_validatePrivateRecording(presentationDate) {
    if (getElement("<%=cboPrivateDocIssuePlace.ClientID%>").value.length == 0) {
      alert("Requiero conocer la ciudad donde se celebró el contrato privado.")
      return false;
    }
    if (getElement("<%=txtPrivateDocIssueDate.ClientID%>").value.length != 0) {
	    if (!isDate(getElement('<%=txtPrivateDocIssueDate.ClientID%>'))) {
		    alert("No reconozco la fecha del acta de asamblea.");
		    return false;
		  }
	    if (!isValidDatePeriod(getElement('<%=txtPrivateDocIssueDate.ClientID%>').value, presentationDate)) {
		    alert("La fecha del contrato privado no puede ser posterior a la fecha de presentación de la inscripción.");
		    return false;
	    }
    } else {
      if (!confirm("No se ha proporcionado la fecha de celebración del contrato privado.\n\n¿Se desconoce la fecha del contrato?")) {
        return false;
      }
    }
    if (getElement("<%=txtPrivateDocNumber.ClientID%>").value.length == 0) {
      alert("Necesito se proporcione el número de contrato privado.")
      return false;
    }
    if (getElement("<%=cboPrivateDocMainWitnessPosition.ClientID%>").value.length == 0) {
      alert("Requiero conocer el cargo público del certificador que avala el contrato privado.")
      return false;
    }
    if (getElement("<%=cboPrivateDocMainWitness.ClientID%>").value.length == 0) {
      alert("Requiero se seleccione el nombre del funcionario público que certificó el contrato privado.")
      return false;
    }
    return true;
  }

  function <%=this.ClientID%>_updateUserInterface(documentTypeTag) {
    getElement("<%=oNotaryRecording.ClientID%>").style.display = 'none';
    getElement("<%=oTitleRecording.ClientID%>").style.display = 'none';
    getElement("<%=oJudicialRecording.ClientID%>").style.display = 'none';
    getElement("<%=oPrivateRecording.ClientID%>").style.display = 'none';

    if (documentTypeTag.length != 0) {
      getElement("<%=this.ClientID%>_" + documentTypeTag).style.display = 'inline';
    }
  }

  function <%=this.ClientID%>_disabledControl(disabledFlag) {
    disableControls(getElement("<%=oNotaryRecording.ClientID%>"), disabledFlag);
    disableControls(getElement("<%=oTitleRecording.ClientID%>"), disabledFlag);
    disableControls(getElement("<%=oJudicialRecording.ClientID%>"), disabledFlag);
    disableControls(getElement("<%=oPrivateRecording.ClientID%>"), disabledFlag);
  }

  function <%=this.ClientID%>_updateControls(sourceName) {
    var url = "../ajax/land.registration.system.data.aspx";
    switch (sourceName) {
      case "oNotaryRecording.IssuePlace":
        url += "?commandName=getNotaryOfficesInPlaceStringArrayCmd";
        url += "&placeId=" + getElement('<%=cboNotaryDocIssuePlace.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboNotaryDocIssueOffice.ClientID%>'));
        return;
     case "oJudicialRecording.IssuePlace":
        url += "?commandName=getJudicialOfficeInPlaceStringArrayCmd";
        url += "&placeId=" + getElement('<%=cboJudicialDocIssuePlace.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboJudicialDocIssueOffice.ClientID%>'));
        return;
      case "oJudicialRecording.IssueOffice":
        url += "?commandName=getJudgesInJudicialOfficeStringArrayCmd";
        url += "&judicialOfficeId=" + getElement('<%=cboJudicialDocIssueOffice.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboJudicialDocIssuedBy.ClientID%>'));
        return;
      case "oPrivateRecording.IssuePlace":
      case "oPrivateRecording.MainWitnessPosition":
        url += "?commandName=getWitnessInPositionStringArrayCmd";
        url += "&placeId=" + getElement('<%=cboPrivateDocIssuePlace.ClientID%>').value;
        url += "&positionId=" + getElement('<%=cboPrivateDocMainWitnessPosition.ClientID%>').value;
        invokeAjaxComboItemsLoader(url, getElement('<%=cboPrivateDocMainWitness.ClientID%>'));
        return;
      default:
        alert("La opción de actualización del UI '" + sourceName + "' no ha sido definida en el programa.")
        return;
    }
  }

  addEvent(getElement('<%=cboNotaryDocIssuePlace.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oNotaryRecording.IssuePlace") } );
  addEvent(getElement('<%=cboJudicialDocIssuePlace.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oJudicialRecording.IssuePlace") } );
  addEvent(getElement('<%=cboJudicialDocIssueOffice.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oJudicialRecording.IssueOffice") } );
  addEvent(getElement('<%=cboPrivateDocIssuePlace.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oPrivateRecording.IssuePlace") } );
  addEvent(getElement('<%=cboPrivateDocMainWitnessPosition.ClientID%>'), 'change', function() { <%=this.ClientID%>_updateControls("oPrivateRecording.MainWitnessPosition") } );
  addEvent(getElement('<%=txtJudicialDocBook.ClientID%>'), 'keypress', upperCaseKeyFilter);
  addEvent(getElement('<%=txtJudicialDocNumber.ClientID%>'), 'keypress', upperCaseKeyFilter);

	/* ]]> */
</script>
 