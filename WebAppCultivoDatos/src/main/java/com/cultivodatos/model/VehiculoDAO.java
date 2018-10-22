package com.cultivodatos.model;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

public interface VehiculoDAO extends CrudRepository<Vehiculo, Long>, VehiculoDAOCustom {
	
	List<Vehiculo> findAll();
	
}
