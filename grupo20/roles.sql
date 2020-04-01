CREATE ROLE 
    role_admin, 
    role_diretor, 
    role_cseguranca;
	
GRANT ALL 
ON role.* 
TO role_admin;    
    
GRANT INSERT, UPDATE, DELETE
ON role.* 
TO role_diretor;     

GRANT SELECT
ON role.* 
TO role_cseguranca; 

