-- consultas --
-- 1 --
select * from usuario;
-- 2 --
select * from administrador join usuario on id_admin=id_usuario;
-- 3 --
select * from compra where id_usuario = 1;
-- 4 --
select * from bonos where id_usuario = 1;
-- 5 --
select * from categoria;
-- 6 --
select * from subcategoria where id_categoria = 3;
-- 7 --
select * from producto where stock>100;
-- 8 --
select * from producto where id_categoria = 1;
-- 9 --
select nombre from producto join item on producto_idproducto = id_producto join carrito on usuario_id_usuario = carrito_usuario_idusuario where usuario_id_usuario = 4;
-- 10 --
select total from carrito where usuario_id_usuario = 1;
-- 11 --
select descripcion from producto where id_producto=1;
-- 13 --
select id_grupo from genealogia where estado = 1; 
-- 14 --
select nombre from usuario join referido on usuario.id_usuario = referido.id_usuario join genealogia on referido.id_grupo = genealogia.id_grupo where genealogia.id_grupo = 2;
-- 15 --
select Codigo from codigo_referido where usuario_id_usuario = 3;

-- Joins --
-- 1 --
select nombre from producto join item on producto_idproducto = id_producto join carrito on usuario_id_usuario = carrito_usuario_idusuario where usuario_id_usuario = 4;
-- 2 --
SELECT u.id_usuario, u.correo, c.id_compra, c.fecha_compra, c.total, c.estado FROM usuario u JOIN compra c ON u.id_usuario = c.id_usuario;

-- 3 --
SELECT producto.nombre, categoria.nombre  
FROM producto  
JOIN categoria ON producto.id_categoria = categoria.id_categoria;

-- 4 --
SELECT producto.nombre, subcategoria.nombre  
FROM producto  
JOIN subcategoria ON producto.id_subcategoria = subcategoria.id_subcategoria;

-- 5 --
SELECT usuario.correo, producto.nombre, item.cantidad  
FROM usuario  
JOIN carrito ON usuario.id_usuario = carrito.usuario_id_usuario  
JOIN item ON carrito.usuario_id_usuario = item.carrito_usuario_idusuario  
JOIN producto ON item.producto_idproducto = producto.id_producto;

-- 6 --
SELECT usuario.correo, bonos.tipo_de_bono, bonos.cantidad_monetaria  
FROM usuario  
JOIN bonos ON usuario.id_usuario = bonos.id_usuario;

-- 7 --
SELECT usuario.correo, genealogia.estado  
FROM usuario  
JOIN referido ON usuario.id_usuario = referido.id_usuario  
JOIN genealogia ON referido.id_grupo = genealogia.id_grupo;

-- 8 --
SELECT usuario.correo, codigo_referido.codigo, codigo_referido.estado  
FROM usuario  
JOIN codigo_referido ON usuario.id_usuario = codigo_referido.usuario_id_usuario;

-- 9 --
SELECT producto.nombre, producto.stock, categoria.nombre  
FROM producto  
JOIN categoria ON producto.id_categoria = categoria.id_categoria;

-- 10 --
SELECT usuario.correo, SUM(item.cantidad) AS total_productos  
FROM usuario  
JOIN carrito ON usuario.id_usuario = carrito.usuario_id_usuario  
JOIN item ON carrito.usuario_id_usuario = item.carrito_usuario_idusuario  
GROUP BY usuario.correo;
-- subconsultas --
-- 1 --
SELECT correo  
FROM usuario  
WHERE id_usuario IN (SELECT id_usuario FROM compra);
-- 2 --
SELECT *  
FROM usuario  
WHERE id_usuario IN (SELECT id_usuario FROM bonos WHERE cantidad_monetaria > 100);

-- 3 --
SELECT *  
FROM subcategoria  
WHERE id_categoria = (SELECT id_categoria FROM categoria WHERE nombre = 'Tecnología');

-- 4 --
SELECT *  
FROM compra  
WHERE id_usuario = (SELECT id_usuario FROM usuario WHERE id_usuario = 2);

-- 5 --
SELECT *  
FROM producto  
WHERE id_categoria = (SELECT id_categoria FROM categoria WHERE nombre = 'Ropa');

-- 6 --
SELECT *  
FROM producto  
WHERE stock < (SELECT AVG(stock) FROM producto);
	
-- 7 --
SELECT *  
FROM producto  
WHERE id_producto IN (SELECT producto_idproducto FROM item);

-- 8 --
SELECT id_usuario, (SELECT SUM(cantidad) FROM item WHERE carrito_usuario_idusuario = usuario.id_usuario) AS total_productos  
FROM usuario;

-- 9 --
SELECT *  
FROM usuario  
WHERE id_usuario IN (SELECT id_usuario FROM referido WHERE id_grupo = 1);

-- 10 --
SELECT *  
FROM codigo_referido  
WHERE usuario_id_usuario IN (SELECT id_usuario FROM compra);

