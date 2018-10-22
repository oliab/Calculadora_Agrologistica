<div class="row mt20">
	<div class="col-lg-12">             				
		<label>¿ Qué vas a vender ?</label>
		<md-autocomplete required
          			 md-no-cache="false"
			      	 md-search-text="txtBusqueda"
      				 md-selected-item-change="cultivoSeleccionado(item)"
      				 md-items="item in buscarCultivos(txtBusqueda)"
      				 md-item-text="item.cultivo"
      				 md-min-length="0"
      				 placeholder="Selecciona tu cultivo">					         
  			<md-item-template>
		       <span class="item-title">		    
		         <span> {{item.cultivo}} </span>
		       </span>					         
		   	 </md-item-template>     
   	 		<md-not-found>
  				No se encontró información
			</md-not-found>             	
       	</md-autocomplete>		                 	       		
	</div> 
</div>  
<div class="row mt20">          			
	<div class="col-lg-12">             			
		<label>¿ Cuánto vas a vender ?</label>
		<input required class="w100" type="number" step="any" ng-model="data.cantidad" placeholder="Peso del cultivo" min="0"  />      						
	</div>
</div>
<div class="row mt20">
	<div class="col-lg-12">	
		<label>Unidad de medida</label>
		<md-radio-group ng-model="data.umedida">					
		  	<md-radio-button value="1" class="md-primary">Kilogramos</md-radio-button>
			<md-radio-button value="2">Toneladas </md-radio-button>					
		</md-radio-group>       						
	</div>             		
</div>