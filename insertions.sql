-- Insertions Script

-- USERS ROLE0 -----------------------------------------------------------
insert into Utilisateurs(idUtilisateur,nom,preNom,dateNe,adresse,telephone,courriel,dateRegistre)
	values 
		('marcos123','Salgado Gomes','Marcos Paulo','1986-02-09','123 Rue Montréal Ouest app D G2R 4J7','1234567890','exemple@ex.com',curdate()),
		('gustavoPach','Pacheco','Gustavo','1985-04-04','Station Guy-concordia','0987654321','exemple_gustavo@ex.com',curdate()),
		('nidhalAfrican','Afrique','Nidhal African','1984-10-24','Montroyal','0981234567','afrique@ex.com',curdate()),
		('user','Nom','Prenom','1234-12-12','123 Rue 123 app 123 Code 123','1231231234','123@ex.com',curdate());
	
    -- users role0 passwords
    insert into UsersMotDePasse(idUtilisateur,mdpEncripte)
	values ('marcos123',AES_ENCRYPT('marcos123','marcos123')),
		   ('gustavoPach',AES_ENCRYPT('123lgp','123lgp')),
		   ('user',AES_ENCRYPT('123','123')),
		   ('nidhalAfrican',AES_ENCRYPT('NidhalAfrican','NidhalAfrican'));

-- USERS ROLE1 AND ROLE2 -------------------------------------------------

insert into Utilisateurs(idUtilisateur,nom,preNom,dateNe,adresse,telephone,courriel,dateRegistre,role)
	values
	('admin','Adm','Adm','2000-10-10','Canada','5555555555','admin@admin.com',curdate(),'role2'),
	('employee','Emp','Emp','2000-10-10','Canada','1111111111','employee@employee.com',curdate(),'role1');

	-- users role1 and role2 passwords
    insert into UsersMotDePasse(idUtilisateur,mdpEncripte)
	values ('admin',AES_ENCRYPT('admin','admin')),
		   ('employee',AES_ENCRYPT('employee','employee'));

-- LIVRES ----------------------------------------------------------------
insert into Livres (idLivre,cdu,titre,dateRegistre,typeLivre)
	values
		('livre','987654321','Nom du livre',curdate(),'regulier'),
		('livre1','123456789','Nom du livre1',curdate(),'regulier'),
		('livre2','123456','Nom du livre2',curdate(),'rare'),
		('livre3','12345-67','Nom du livre3',curdate(),'rare');
        
	-- Authors
    insert into Auteurs (idAuteur,p_a_PreNom, p_a_Nom,anneeNe,anneeMort,s_a_PreNom,s_a_Nom,t_a_PreNom,t_a_Nom)
		values
			(0,'Prenom1Livre','Nom1Livre',1940,2018,'Prenom2Livre','Nom2Livre','Prenom3Livre','Nom3Livre'),
			(1,'Prenom1Livre1','Nom1Livre1',1930,1980,'Prenom2Livre1','Nom2Livre1','Prenom3Livre1','Nom3Livre1'),
			(2,'Prenom1Livre2','Nom1Livre2',1923,1995,'Prenom2Livre2','Nom2Livre2','Prenom3Livre2','Nom3Livre2'),
			(3,'Prenom1Livre3','Nom1Livre3',1932,1972,'Prenom2Livre3','Nom2Livre3','Prenom3Livre3','Nom3Livre3');
            
	-- Edition
    insert into Editions(isbn,maisonPub,edition,villePub,anneePub,pages,prix) 
		values
			(000,'maisonPub0',1,'villePub0','1950',100,20.00),
			(111,'maisonPub1',2,'villePub1','1970',200,20.10),
			(222,'maisonPub2',3,'villePub2','1980',300,2020.20),
			(333,'maisonPub3',4,'villePub3','1990',400,333.30);
            
	-- Livres_Editions
	insert into Livres_Editions(isbn,idLivre,idAuteur) 
		values
			(000,'livre',0),
			(111,'livre1',1),
			(222,'livre2',2),
			(333,'livre3',3);
        
-- RENDEZ-VOUS -----------------------------------------------------------
insert into RendezVous(idRendezVous,idLivre,idUtilisateur,datePrevue,typeRV,statusRV) 
	values
		(1,'livre2','marcos123','2018-09-02','journee','attente'),
        (2,'livre3','nidhalAfrican','2018-09-15','apresmidi','annule');
        
-- EMPRUNTS --------------------------------------------------------------
insert into Emprunts(idEmprunt,idLivre,idUtilisateur,dateEmp,dateRen,statusEM) 
	values
		(0,'livre','marcos123','2018-07-30','2018-08-14','fini'),
		(1,'livre','nidhalAfrican','2018-08-15','2018-08-29','fini'),
		(2,'livre1','nidhalAfrican','2018-08-01','2018-08-15','fini'),
        (3,'livre','nidhalAfrican','2018-08-30','2018-09-12','cours'),
		(4,'livre1','gustavoPach','2018-08-16','2018-09-01','cours');
        
-- RESERVATIONS ----------------------------------------------------------
insert into Reservations(idReservation,idLivre,idUtilisateur,datePrevue,statusRS) 
	values
		(0,'livre','user', '2018-07-30', 'annule'),
		(1,'livre1','nidhalAfrican','2018-08-01', 'fini'),
		(2,'livre','nidhalAfrican','2018-08-15', 'fini'),
		(3,'livre1','gustavoPach','2018-08-16', 'fini');
        
-- HISTORIQUE LIVRES -----------------------------------------------------
insert into HistoriquesLivres(idLivre,statusHL,dateStatus) 
	values
		('livre','renovation','2001-08-10'),
		('livre1','renovation','2001-08-11'),
        ('livre2','renovation','2001-08-12'),
        ('livre3','renovation','2001-08-13');
        
-- AMANDES ---------------------------------------------------------------
insert into Amendes(idAmende,idUtilisateur,idEmprunts,dateAmende,valeur,datePaye) 
	values
		(1,'gustavoPach',0,'2018-08-16',2.00,null);      
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        