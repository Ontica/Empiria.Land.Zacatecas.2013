<thead>
  <%=((Empiria.Presentation.Web.MultiViewDashboard) this.Page).ViewTitle%>
  <tr>
    <th colspan="3">
			<a href="javascript:sendPageCommand('sortData', 'FilesFolderDisplayName ASC')">Directorio de im�genes</a> / 
			<a href="javascript:sendPageCommand('sortData', 'FilesCount ASC')">N�mero de im�genes</a> / 
			<a href="javascript:sendPageCommand('sortData', 'FilesTotalSize ASC')">Tama�o</a> / 
			<a href="javascript:sendPageCommand('sortData', 'LastUpdateDate ASC')">�ltima modificaci�n</a>    			
		</th>
  </tr>
</thead>
<%# ((Empiria.Presentation.Web.MultiViewDashboard) this.Page).HintContent%>
