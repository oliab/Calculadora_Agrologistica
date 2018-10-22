<div class="calculadora">
	<md-list flex>
	  <md-list-item class="step md-3-line lst" ng-class="{ 'active' : $first }"  ng-repeat="section in sections">
	    <md-button class="step-button md-fab md-mini"
	               ng-click="switchSections($index, '')"
	               ng-attr-id="step-{{$index + 1}}" style="background:green">
	      {{$index + 1}}
	    </md-button>
	    <div class='step-line' ng-hide="$last"></div>
	    <div class="md-list-item-text header_lst">
	      <div class='step-title' ng-click="switchSections($index, '')">
	        {{section.title}}
	      </div>
	      <div class='step-container' ng-hide="!selected($index)">
	      	<button class="button btn-info btn-sm pull-right _close" ng-click="cerrarSection()">
	      			<i class="fa fa-close"></i>
   			 </button>
	        <div class="step-content" style="margin-bottom:60px;">
	        
	        
	        </div>
	        <div class="row mt20">
	        	<md-button class="next-step button btn-info btn-sm pull-right"
	                   ng-click="switchSections($index + 1, '')"
	                   ng-if="!$last">Continuar</md-button>
	        		<ng-transclude ng-if="$last"></ng-transclude>
	        	<md-button class="last-step  button btn-default btn-sm pull-left"
	                   ng-click="switchSections($index - 1, '')"
	                   ng-if="!$first">Regresar</md-button>
	        </div>
	        
	      </div>
	    </div>
	  </md-list-item>
	</md-list>
</div>