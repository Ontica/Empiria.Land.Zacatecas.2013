<thead>
  <%=((Empiria.Presentation.Web.MultiViewDashboard) this.Page).ViewTitle%>
  <tr>
    <th>
			<a href="javascript:sendPageCommand('sortData', 'FilesFolderDisplayName ASC')">Directorio</a> / 
			<a href="javascript:sendPageCommand('sortData', 'FilesCount ASC')">Im�genes</a> / 
			<a href="javascript:sendPageCommand('sortData', 'FilesTotalSize ASC')">Tama�o</a> / 
			<a href="javascript:sendPageCommand('sortData', 'LastUpdateDate ASC')">Modificado</a>
		</th>
    <th>Informaci�n del libro registral</th>
    <th>�Qu� debo hacer?</th>
  </tr>
</thead>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).HintContent%>
