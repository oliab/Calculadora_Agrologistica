<div class="row mt20">
	<div class="col-lg-12">
	  <label>¿ Cómo transportarás tu cultivo ?</label>			             				  			             				 
	  <md-select ng-model="data.idVeh" placeholder="Vehículo">
	     <md-optgroup  ng-repeat="cat in catVeh" label="{{cat.categoria}}">
	       	<md-option ng-repeat="veh in vehiculos | filter:{ id_tveh: cat.id_tipo }" ng-value="veh.clave">{{veh.vehiculo}}</md-option>
	     </md-optgroup>
	  </md-select>
	</div>
</div>

<div class="row mt20">
	<div class="col-lg-12">
	  <label>¿ Cuántos ejes excedentes ?</label>			             				  			             				 
	  <md-select ng-model="data.ejes" placeholder="Ejes excedentes">		    
       		<md-option ng-repeat="eje in ejes" ng-value="eje.clave">{{eje.eje}}</md-option>		    
	  </md-select>
	</div>
</div>