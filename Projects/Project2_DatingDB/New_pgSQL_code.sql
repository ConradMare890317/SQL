CREATE TABLE my_contacts(
    contact_id bigserial,
    last_name character varying,
    first_name character varying,
    phone numeric,
    email character varying,
    gender "char",
    birthday date,
    prof_id integer,
    postal_id integer,
    status_id integer,
    PRIMARY KEY (contact_id)
);

CREATE TABLE interests(
    interest_id bigserial,
    interest character varying,
    PRIMARY KEY (interest_id)
);

CREATE TABLE seeking(
    seeking_id bigserial,
    seeking character varying,
    PRIMARY KEY (seeking_id)
);

CREATE TABLE profession(
    prof_id serial,
    profession character varying,
    PRIMARY KEY (prof_id)
);

CREATE TABLE postal_code(
    postal_id smallserial,
    province character varying,
    city character varying,
    suburb character varying,
    postal_code character varying,
    PRIMARY KEY (postal_id)
);

CREATE TABLE status(
    status_id smallserial,
    status character varying,
    PRIMARY KEY (status_id)
);

CREATE TABLE my_contacts_interests(
    my_contacts_contact_id bigserial,
    interests_interest_id bigserial
);

CREATE TABLE seeking_my_contacts(
    seeking_seeking_id bigserial,
    my_contacts_contact_id bigserial
);



ALTER TABLE my_contacts_interests
    ADD FOREIGN KEY (my_contacts_contact_id)
    REFERENCES my_contacts (contact_id)
    NOT VALID;
	
ALTER TABLE my_contacts_interests
    ADD FOREIGN KEY (interests_interest_id)
    REFERENCES interests (interest_id)
    NOT VALID;
	
ALTER TABLE seeking_my_contacts
    ADD FOREIGN KEY (seeking_seeking_id)
    REFERENCES seeking (seeking_id)
    NOT VALID;
	
ALTER TABLE seeking_my_contacts
    ADD FOREIGN KEY (my_contacts_contact_id)
    REFERENCES my_contacts (contact_id)
    NOT VALID;
	
ALTER TABLE my_contacts
    ADD FOREIGN KEY (postal_id)
    REFERENCES postal_code (postal_id)
    NOT VALID;
	
ALTER TABLE my_contacts
    ADD FOREIGN KEY (prof_id)
    REFERENCES profession (prof_id)
    NOT VALID;
	
ALTER TABLE my_contacts
    ADD FOREIGN KEY (status_id)
    REFERENCES status (status_id)
    NOT VALID;