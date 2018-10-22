package com.cultivodatos.model;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

public interface PreciosDAO extends CrudRepository<Precios, Integer>, PreciosDAOCustom {

	List<Precios> findAll();
}
