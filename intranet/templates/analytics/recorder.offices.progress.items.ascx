<%@ Import Namespace="Empiria.Presentation" %>
<%@ Import Namespace="Empiria.Government.LandRegistration" %>
<%@ Import Namespace="Empiria.Government.LandRegistration.UI" %>
<%# ((int) DataBinder.Eval(Container, "ItemIndex")) == 0 ? "<tbody>" : String.Empty %>
<tr class="<%# ((int) DataBinder.Eval(Container, "ItemIndex") % 2 == 0 ? String.Empty  : "oddDataRow") %>" onmouseover="dataGridRowSelect(this, true);" onmouseout="dataGridRowSelect(this, false);">
	<td style="white-space:nowrap;" width="30%">
    <a class="detailsLinkTitle"><%# DataBinder.Eval(Container, "DataItem.RecorderOffice")%></a>
	</td>
	<td style="white-space:nowrap;">
    <table class="ghostTable">
      <tr><td>Libros de traslativo:&nbsp;&nbsp;&nbsp;</td><td align="right" style='width:120px'><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.DomainTotalBooks")).ToString("N0")%></span></td><td>&nbsp;</td></tr>
      <tr><td>Libros creados:</td><td align="right"><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.DomainCreatedBooks")).ToString("N0")%></span></td><td align="right">&nbsp; &nbsp; &nbsp;<span class='boldItem'><%#((decimal)DataBinder.Eval(Container, "DataItem.CreatedBookPct")).ToString("P1")%></span></td></tr>
      <tr><td>Libros por crear: </td><td align="right"><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.DomainNotCreatedBooks")).ToString("N0")%></span></td><td align="right">&nbsp; &nbsp; &nbsp;<span class='boldItem'><%#((decimal)DataBinder.Eval(Container, "DataItem.NotCreatedBookPct")).ToString("P1")%></span></td></tr>
    </table>
	</td>
  <td style="white-space:nowrap;">
    <table class="ghostTable">
      <tr><td>Total im�genes:&nbsp;&nbsp;&nbsp;</td><td align="right" style='width:120px'><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.DomainFilesCount")).ToString("N0")%></span></td><td>&nbsp;</td></tr>
      <tr><td>No legibles:</td><td align="right"><span class='boldItem'><%#((decimal)DataBinder.Eval(Container, "DataItem.NoLegibleToReplaceImages")).ToString("N0")%></span></td><td align="right">&nbsp; &nbsp; &nbsp;<span class='boldItem'><%#((decimal)DataBinder.Eval(Container, "DataItem.NoLegibleToReplaceImagesPct")).ToString("P2")%></span></td></tr>
      <tr><td>Proyectadas:</td><td align="right"><span class='boldItem'><%#((decimal)DataBinder.Eval(Container, "DataItem.NoLegibleToReplaceImagesPry")).ToString("N0")%></span></td><td align="right">&nbsp; &nbsp; &nbsp;<span class='boldItem'><%#((decimal)DataBinder.Eval(Container, "DataItem.NoLegibleToReplaceImagesPryPct")).ToString("P2")%></span></td></tr>
    </table>
	</td>
  <td style="white-space:nowrap;">
    <table class="ghostTable">
      <tr><td>Total inscripciones:&nbsp;&nbsp;&nbsp;</td><td align="right" style='width:120px'><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.DomainRecordingsControlCount")).ToString("N0")%></span></td><td>&nbsp;</td></tr>
      <tr><td>Registradas:</td><td align="right"><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.CapturedRecordingsCount")).ToString("N0")%></span></td><td align="right">&nbsp; &nbsp; &nbsp;<span class='boldItem'><%#((decimal)DataBinder.Eval(Container, "DataItem.CapturedRecordingsPct")).ToString("P2")%></span></td></tr>
      <tr><td>Por registrar: </td><td align="right"><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.LeftCapturedRecordingsCount")).ToString("N0")%></span></td><td align="right">&nbsp; &nbsp; &nbsp;<span class='boldItem'><%#((decimal)DataBinder.Eval(Container, "DataItem.LeftCapturedRecordingsPct")).ToString("P2")%></span></td></tr>
    </table>
	</td>
  <td style="white-space:nowrap;">
    <table class="ghostTable">
      <tr><td>No legibles:&nbsp;&nbsp;&nbsp;</td><td align="right"><span class='boldItem'><%#((decimal)DataBinder.Eval(Container, "DataItem.NoLegibleRecordingsPct")).ToString("P2")%></span></td></tr>
      <tr><td>Reales:</td><td align="right" style='width:120px'><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.NoLegibleRecordingsCount")).ToString("N0")%></span></td></tr>
      <tr><td>Proyectadas: </td><td align="right"><span class='boldItem'><%#((decimal)DataBinder.Eval(Container, "DataItem.NoLegibleRecordingsPry")).ToString("N0")%></span></td></tr>
    </table>
	</td>
  <td style="white-space:nowrap;">
    <table class="ghostTable">
      <tr><td>No vigentes:&nbsp;&nbsp;&nbsp;</td><td align="right"><span class='boldItem'><%#((decimal)DataBinder.Eval(Container, "DataItem.ObsoleteRecordingsPct")).ToString("P2")%></span></td></tr>
      <tr><td>Reales:</td><td align="right" style='width:120px'><span class='boldItem'><%#((int)DataBinder.Eval(Container, "DataItem.ObsoleteRecordingsCount")).ToString("N0")%></span></td></tr>
      <tr><td>Proyectadas: </td><td align="right"><span class='boldItem'><%#((decimal)DataBinder.Eval(Container, "DataItem.ObsoleteRecordingsPry")).ToString("N0")%></span></td></tr>
    </table>
	</td>
	<td width="30%">&nbsp;</td>
</tr>