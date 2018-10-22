package com.cultivodatos.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class InicioCtrl {
	
	@RequestMapping(value={"/", "/inicio"}, method = RequestMethod.GET) 
	public ModelAndView inicio() {
		ModelAndView mv = new ModelAndView("Inicio");
		return mv;
	}
	
	@RequestMapping(value={"encabezado"}, method = RequestMethod.GET) 
	public ModelAndView encabezado() {
		ModelAndView mv = new ModelAndView("encabezado");
		return mv;
	}
	
	@RequestMapping(value={"piepagina"}, method = RequestMethod.GET) 
	public ModelAndView piepagina() {
		ModelAndView mv = new ModelAndView("piepagina");
		return mv;
	}

	@RequestMapping(value={"calculadora"}, method = RequestMethod.GET) 
	public ModelAndView calculadora() {
		ModelAndView mv = new ModelAndView("calculadora");
		return mv;
	}
	
	
	@RequestMapping(value={"cultivo"}, method = RequestMethod.GET) 
	public ModelAndView cultivo() {
		ModelAndView mv = new ModelAndView("cultivo");
		return mv;
	}
	
	
	@RequestMapping(value={"vehiculo"}, method = RequestMethod.GET) 
	public ModelAndView vehiculo() {
		ModelAndView mv = new ModelAndView("vehiculo");
		return mv;
	}
	
	
	@RequestMapping(value={"ubicacion"}, method = RequestMethod.GET) 
	public ModelAndView ubicacion() {
		ModelAndView mv = new ModelAndView("ubicacion");
		return mv;
	}
	
	
}
