package com.cultivodatos.model;

import java.util.List;

import org.springframework.data.jpa.repository.query.Procedure;

public interface VehiculoDAOCustom {

	List<Vehiculo> getVehiculos();
}
