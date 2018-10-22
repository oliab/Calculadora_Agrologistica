 <div class="row mt20">
	<div class="col-lg-12">	
		<label>Tipo de Ubicación</label>
		<md-radio-group ng-model="data.utipo">					
		  	<md-radio-button value="1" class="md-primary">Referencia</md-radio-button>
			<md-radio-button value="2">Coordenadas</md-radio-button>					
		</md-radio-group>       						
	</div>             		
</div>

<div class="row mt20" ng-show="data.utipo == 1">
 	<div class="col-lg-12">
		<label>¿ Dónde se encuentra tu producto ?</label>
	 	<div class="wrapperBusqueda">
		  	<md-autocomplete  id="sitios"
	                  md-item-text="item.nombre"
	                  md-search-text="txtSitio"
                      md-items="item in buscarSitiosSakbeJson(txtSitio)" 
                      md-selected-item-change="cambioSitio(item)"                      
                      md-selected-item="selSitio" 
                      md-no-cache="false"
                      ng-model-options="{debounce: 500}"							                            
                      md-input-name="autocompleteSitio"                
                      required>
         		<md-item-template>
           			<span md-highlight-text="txtSitio">{{item.nombre}}</span>
         		</md-item-template>	
        		<md-not-found>
  					No se encontró información
				</md-not-found> 					            
      		</md-autocomplete>
	   </div>
    </div>
 </div>
 
 <div class="row mt20" ng-show="data.utipo == 2">
 	<div class="col-lg-12">
 		<p>{{data.lat}},{{data.lng}}</p> 
 	</div>
 </div>