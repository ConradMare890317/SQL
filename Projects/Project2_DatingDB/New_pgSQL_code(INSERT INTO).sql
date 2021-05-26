INSERT INTO interests(interest)
VALUES
	('Cycling'),('Travel'),('Golf'),('Socializing'),
	('Gaming'),('Aviation'),('Code'),('Technology');
	
INSERT INTO seeking(seeking)
VALUES
	('Friends'),('Long-term commitment'),('Date'),('Companion');

INSERT INTO status(status)
VALUES
	('Single'),('Widowed'),('It''s complicated');
	
INSERT INTO profession(profession)
VALUES
	('Lawyer'),('Doctor'),('Pilot'),('Public Services'),('Other');
	

INSERT INTO postal_code(province, city,suburb,postal_code)
VALUES
	('GP','Pretoria', 'The Willows', '0184'),
	('KZN','Durban', 'Pennington', '1111'),
	('WC','Paarl', 'Stellenbosch', '2222');
	
INSERT INTO my_contacts(first_name,last_name,phone,email,gender,birthday, prof_id,postal_id,status_id)
VALUES
	('Tian','van Eijk','082123456','tve@yahoo.com','Male','03 August 1989',1,1,1),
	('Erik','Botha','076123456','erbo@outlook.com','Male','27 March 1989',2,1,2),
	('Brody','Dale','079654321','bd@hotmail.com','Female','21 June 1982',5,2,3);
	
INSERT INTO my_contacts_interests(my_contacts_contact_id,interests_interest_id)
VALUES
	(1,1),(1,3),(1,6),(1,8),
	(2,3),(2,5),(2,7),(2,8),
	(3,4),(3,6),(3,2),(3,5);
	
INSERT INTO seeking_my_contacts(my_contacts_contact_id,seeking_seeking_id)
VALUES
	(1,2),(1,4),
	(2,2),
	(3,1),(3,2),(3,3),(3,4);