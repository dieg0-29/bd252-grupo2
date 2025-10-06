Project FerreteriaAbastecimiento {
  database_type: "PostgreSQL"
}

/* =========================
   TABLAS PRINCIPALES
   ========================= */

Table AREA {
  id_area varchar [pk]
  nombre_area varchar [not null, unique]
}

Table EMPLEADO {
  id_empleado varchar [pk]
  id_area varchar [not null, ref: > AREA.id_area]
  numero_contacto varchar [not null]
  correo_contacto varchar [not null, unique]
  fecha_registro date [not null]
}

Table ROL {
  id_rol varchar [pk]
  nombre_rol varchar [not null, unique]
  tipo_rol varchar [not null]
  descripcion_rol varchar [not null]
}

Table ROL_EMPLEADO {
  id_empleado varchar [not null, ref: > EMPLEADO.id_empleado]
  id_rol varchar [not null, ref: > ROL.id_rol]
  fecha_asignacion date [not null]
  indexes {
    (id_empleado, id_rol) [pk]
  }
}

Table PRODUCTO {
  id_producto varchar [pk]
  nombre_producto varchar [not null]
  unidad_medida varchar [not null]
  precio_base decimal(12,2) [not null]
}

Table TIPO {
  codigo_tipo varchar [pk]
  nombre_tipo varchar [not null]
}

Table PRODUCTO_TIPO {
  codigo_tipo varchar [not null, ref: > TIPO.codigo_tipo]
  id_producto varchar [not null, ref: > PRODUCTO.id_producto]
  
  indexes {
    (id_producto, codigo_tipo) [pk]
  }
}

Table PROVEEDOR {
  id_proveedor varchar [pk]
  nombre_comercial varchar [not null]
  razon_social varchar [not null]
  ruc varchar [not null, unique]
}

Table PROVEEDOR_CONTACTO {
  id_proveedor varchar [not null, ref: > PROVEEDOR.id_proveedor]
  tipo_contacto varchar [not null]
  valor_contacto varchar [not null]
  indexes {
    (id_proveedor, tipo_contacto) [pk]
  }
}

Table SOLICITUD_DE_COTIZACION {
  id_solicitud varchar [pk]
  id_empleado varchar [not null, ref: > EMPLEADO.id_empleado]
  fecha_emision_solicitud date [not null]
  estado varchar [not null]
}

Table COTIZACION {
  id_cotizacion varchar [pk]
  id_solicitud varchar [not null, ref: > SOLICITUD_DE_COTIZACION.id_solicitud]
  id_proveedor varchar [not null, ref: > PROVEEDOR.id_proveedor]
  fecha_emision_cotizacion date [not null]
  fecha_garantia date [not null]
  monto_total decimal(12,2) [not null]
  plazo_entrega int [not null]
}

Table DETALLE_SOLICITUD {
  id_producto varchar [not null, ref: > PRODUCTO.id_producto]
  id_solicitud varchar [not null, ref: > SOLICITUD_DE_COTIZACION.id_solicitud]
  cantidad_solicitada int [not null]
  indexes {
    (id_solicitud, id_producto) [pk]
  }
}

Table DETALLE_COTIZACION {
  id_cotizacion varchar [not null, ref: > COTIZACION.id_cotizacion]
  id_producto varchar [not null, ref: > PRODUCTO.id_producto]
  costo_total decimal(12,2) [not null]
  modalidad_pago varchar [not null]
  indexes {
    (id_cotizacion, id_producto) [pk]
  }
}

Table PRODUCTO_PROVEEDOR {
  id_producto varchar [not null, ref: > PRODUCTO.id_producto]
  id_proveedor varchar [not null, ref: > PROVEEDOR.id_proveedor]
  precio_unitario_ref decimal(12,2) [not null]
  indexes {
    (id_proveedor, id_producto) [pk]
  }
}

Table PEDIDO_DE_ABASTECIMIENTO {
  id_pedido varchar [pk]
  id_empleado varchar [not null, ref: > EMPLEADO.id_empleado]
  fecha_pedido date [not null]
  hora_pedido time [not null]
  estado_pedido varchar [not null]
}

Table DETALLE_PEDIDO {
  id_pedido varchar [not null, ref: > PEDIDO_DE_ABASTECIMIENTO.id_pedido]
  id_producto varchar [not null, ref: > PRODUCTO.id_producto]
  cantidad_requerida int [not null]
  fecha_requerida date [not null]
  ubicacion_envio varchar [not null]
  indexes {
    (id_pedido, id_producto) [pk]
  }
}

Table ORDEN_DE_COMPRA {
  id_orden varchar [pk]
  id_cotizacion varchar [not null, ref: > COTIZACION.id_cotizacion]
  fecha_emision date [not null]
  monto decimal(12,2) [not null]
  estado varchar [not null]
}

Table DETALLE_OC {
  id_orden varchar [not null, ref: > ORDEN_DE_COMPRA.id_orden]
  id_producto varchar [not null, ref: > PRODUCTO.id_producto]
  indexes {
    (id_orden, id_producto) [pk]
  }
}

Table MONITOREO_DE_COMPRA {
  id_monitoreo varchar [pk]
  id_orden varchar [not null, ref: > ORDEN_DE_COMPRA.id_orden]
  fecha_entrega date [not null]
  hora_entrega time
  estado varchar [not null]
}

Table RECEPCION {
  id_recepcion varchar [pk]
  id_orden varchar [not null, ref: > ORDEN_DE_COMPRA.id_orden]
  fecha_recepcion date [not null]
  hora_inicio_recepcion time [not null]
  hora_fin_recepcion time [not null]
  fecha_programada date [not null]
  hora_programada time
  empleado_encargado varchar [not null , ref: > EMPLEADO.id_empleado]
  observacion varchar
}

Table GUIA_DE_REMISION {
  serie_correlativo varchar [pk]
  id_recepcion varchar [not null, unique, ref: > RECEPCION.id_recepcion]
  fecha_emision_guia date [not null]
  fecha_traslado_guia date [not null]
}

Table ALMACEN {
  id_almacen varchar [pk]
  nro_almacen varchar [not null, unique]
  ubicacion varchar [not null]
}

Table RECEPCION_ALMACEN {
  id_recepcion varchar [not null, ref: > RECEPCION.id_recepcion]
  id_almacen varchar [not null, ref: > ALMACEN.id_almacen]
  indexes {
    id_recepcion [pk]  // una recepción apunta a un único almacén
  }
}

Table PEDIDO_DE_TRANSPORTE {
  id_pedido_transporte varchar [pk]
  id_recepcion varchar [not null, unique, ref: > RECEPCION.id_recepcion]
  fecha_pedido_transporte date [not null]
  hora_pedido_transporte time
  estado_pedido_transporte varchar [not null]
}

Table RECLAMO {
  id_reclamo varchar [pk]
  id_recepcion varchar [not null, ref: > RECEPCION.id_recepcion]
  fecha_reclamo date [not null]
  hora_reclamo time [not null]
  estado_reclamo varchar [not null]
}

Table NOTA_DE_CREDITO {
  id_reclamo varchar [not null, ref: > RECLAMO.id_reclamo]
  nro_nc smallint [not null]
  fecha_nc date [not null]
  motivo_nc varchar [not null]
  monto_nc decimal(12,2) [not null]
  descripcion_nc varchar
  indexes {
    (id_reclamo, nro_nc) [pk]
  }
}

Table CAMBIO_DE_PRODUCTO {
  id_reclamo varchar [not null, ref: > RECLAMO.id_reclamo]
  nro_cambio smallint [not null]
  fecha_cambio date [not null]
  hora_cambio time [not null]
  motivo_cambio varchar [not null]
  descripcion_cambio varchar
  indexes {
    (id_reclamo, nro_cambio) [pk]
  }
}

Table DETALLE_RECEPCION {
  id_recepcion varchar [not null, ref: > RECEPCION.id_recepcion]
  id_producto varchar [not null, ref: > PRODUCTO.id_producto]
  cantidad_conforme int [not null]
  cantidad_defectuosa int [not null]
  cantidad_recibida int [not null] // = conforme + defectuosa (validar en trigger)
  indexes {
    (id_recepcion, id_producto) [pk]
  }
}
