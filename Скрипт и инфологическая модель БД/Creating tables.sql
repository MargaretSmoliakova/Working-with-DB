USE var9;

CREATE TABLE branch
	([ID] SMALLINT IDENTITY(1, 1) NOT NULL,
	 [location] NVARCHAR(50) NOT NULL,
	 [number_of_workplaces] SMALLINT NOT NULL,
	 CONSTRAINT prim_branch PRIMARY KEY (ID));

CREATE TABLE stall 
	([ID] SMALLINT IDENTITY(1, 1) NOT NULL,
	 [location] NVARCHAR(50) NOT NULL,
	 [number_of_workplaces] SMALLINT NOT NULL,
	 [branch_ID] SMALLINT NOT NULL,
	 CONSTRAINT prim_stall PRIMARY KEY (ID),
	 CONSTRAINT foreign_stall_to_branch FOREIGN KEY (branch_ID) REFERENCES branch (ID) ON DELETE CASCADE);

CREATE TABLE photoshop
	([ID] SMALLINT IDENTITY(1, 1) NOT NULL,
	 [location] SMALLINT NOT NULL,
	 CONSTRAINT prim_photoshop PRIMARY KEY (ID));

CREATE TABLE workplaces_stall
	([ID] SMALLINT IDENTITY(1, 1) NOT NULL,
	 [stall_ID] SMALLINT NOT NULL,
	 [position] NVARCHAR(50) NOT NULL,
	 CONSTRAINT prim_workplaces_stall PRIMARY KEY (ID),
	 CONSTRAINT foreign_workplaces_stall_to_stall FOREIGN KEY (stall_ID) REFERENCES stall (ID) ON DELETE CASCADE);

CREATE TABLE workplaces_branch
	([ID] SMALLINT IDENTITY(1, 1) NOT NULL,
	 [branch_ID] SMALLINT NOT NULL,
	 [position] NVARCHAR(50) NOT NULL,
	 CONSTRAINT prim_workplaces_branch PRIMARY KEY (ID),
	 CONSTRAINT foreign_workplaces_branch_to_branch FOREIGN KEY (branch_ID) REFERENCES branch (ID) ON DELETE CASCADE);

CREATE TABLE discount_private
	([ID] SMALLINT NOT NULL,	 
	 [branch_ID] SMALLINT NOT NULL,
	 [discount] MONEY NOT NULL,
	 CONSTRAINT prim_discount_private PRIMARY KEY (ID),
	 CONSTRAINT foreign_discount_private_to_branch FOREIGN KEY (branch_ID) REFERENCES branch (ID));

CREATE TABLE client
	([ID] SMALLINT IDENTITY(1, 1) NOT NULL,
	 [full_name] NVARCHAR(50) NOT NULL,
	 [type] NVARCHAR(20) NOT NULL,
	 [discount_card] NVARCHAR(3) NOT NULL,
	 [discount_private_ID] SMALLINT NULL,
	 CONSTRAINT prim_client PRIMARY KEY (ID),
	 CONSTRAINT foreign_client_to_discount_private FOREIGN KEY (discount_private_ID) REFERENCES discount_private (ID),
	 CONSTRAINT check_client_type CHECK ([type] IN ('любитель', 'профессионал')),
	 CONSTRAINT check_discount_card CHECK ([discount_card] IN ('да', 'нет')));

CREATE TABLE orders_color_development
	([ID] SMALLINT IDENTITY(1, 1) NOT NULL,
	 [client_ID] SMALLINT NOT NULL,
	 [film_purchased_here] NVARCHAR(10) NOT NULL,	 
	 [price] MONEY NOT NULL,
	 CONSTRAINT prim_orders_color_development PRIMARY KEY (ID),
	 CONSTRAINT foreign_orders_color_development_to_client FOREIGN KEY (client_ID) REFERENCES client (ID));

CREATE TABLE orders_photo_print
	([ID] SMALLINT IDENTITY(1, 1) NOT NULL,
	 [client_ID] SMALLINT NOT NULL,
	 [number_of_photos_on_each_frame] SMALLINT NOT NULL,
	 [number_of_photo] INT NOT NULL,
	 [dimension_of_paper] NVARCHAR(20) NOT NULL,
	 [type_of_paper] NVARCHAR(20) NOT NULL,
	 [urgency] NVARCHAR(10) NOT NULL,
	 [price] MONEY NOT NULL,	 
	 CONSTRAINT prim_orders_photo_print PRIMARY KEY (ID),
	 CONSTRAINT foreign_orders_photo_print_to_client FOREIGN KEY (client_ID) REFERENCES client (ID),
	 CONSTRAINT check_urgency CHECK ([urgency] IN ('срочно', 'не горит')));

CREATE TABLE orders_branch
	([ID] INT IDENTITY(1, 1) NOT NULL,
	 [date] DATE NOT NULL,
	 [branch_ID] SMALLINT NOT NULL,
	 [stall_ID] SMALLINT NULL,	 
	 [orders_color_development_ID] SMALLINT NULL,
	 [orders_photo_print_ID] SMALLINT NULL,	 
	 CONSTRAINT prim_orders_branch PRIMARY KEY (ID),
	 CONSTRAINT foreign_orders_branch_to_branch FOREIGN KEY (branch_ID) REFERENCES branch (ID),
	 CONSTRAINT foreign_orders_branch_to_stall FOREIGN KEY (stall_ID) REFERENCES stall (ID),
	 CONSTRAINT foreign_orders_branch_to_orders_color_development FOREIGN KEY (orders_color_development_ID) REFERENCES orders_color_development (ID),
	 CONSTRAINT foreign_orders_branch_to_orders_photo_print FOREIGN KEY (orders_photo_print_ID) REFERENCES orders_photo_print (ID));

CREATE TABLE photo_products
	([ID] SMALLINT IDENTITY(1, 1) NOT NULL,
	 [type] NVARCHAR(50) NOT NULL,
	 [created_by_entity] NVARCHAR(50) NULL,
	 CONSTRAINT prim_photo_products PRIMARY KEY (ID));

CREATE TABLE additional_services
	([ID] SMALLINT IDENTITY(1, 1) NOT NULL,
	 [type] NVARCHAR(50) NOT NULL,
	 CONSTRAINT prim_additional_services PRIMARY KEY (ID),
	 CONSTRAINT check_type_additional_services CHECK ([type] IN ('фотографии на документы', 'реставрация фотографий', 'прокат фотоаппаратов', 'художественное фото', 'предоставление услуг профессионального фотографа')));

CREATE TABLE purchased_photo_products_stall
	([ID] INT IDENTITY(1, 1) NOT NULL,
	 [date] DATE NOT NULL,
	 [stall_ID] SMALLINT NOT NULL,
	 [photo_products_ID] SMALLINT NOT NULL
	 CONSTRAINT prim_purchased_photo_products_stall PRIMARY KEY(ID),
	 CONSTRAINT foreign_purchased_photo_products_stall_to_stall FOREIGN KEY (stall_ID) REFERENCES stall (ID),
	 CONSTRAINT foreign_purchased_photo_products_stall_to_photo_products FOREIGN KEY (photo_products_ID) REFERENCES photo_products (ID));

CREATE TABLE purchased_photo_products_photoshop
	([ID] INT IDENTITY(1, 1) NOT NULL,
	 [date] DATE NOT NULL,
	 [photoshop_ID] SMALLINT NOT NULL,
	 [photo_products_ID] SMALLINT NOT NULL
	 CONSTRAINT prim_purchased_photo_products_photoshop PRIMARY KEY(ID),
	 CONSTRAINT foreign_purchased_photo_products_photosho_to_photoshop FOREIGN KEY (photoshop_ID) REFERENCES photoshop (ID),
	 CONSTRAINT foreign_purchased_photo_products_photoshop_to_photo_products FOREIGN KEY (photo_products_ID) REFERENCES photo_products (ID));

CREATE TABLE orders_made_all
	([ID] INT IDENTITY(1, 1) NOT NULL,
	 [date] DATE NOT NULL,
	 [orders_branch_ID] INT NULL,
	 CONSTRAINT prim_orders_all PRIMARY KEY (ID),
	 CONSTRAINT foreign_orders_made_all_to_orders_branch FOREIGN KEY (orders_branch_ID) REFERENCES orders_branch (ID));

CREATE TABLE rendered_services
	([ID] INT IDENTITY(1, 1) NOT NULL,
	 [date] DATE NOT NULL,
	 [photoshop_ID] SMALLINT NOT NULL,
	 [additional_services_ID] SMALLINT NOT NULL,
	 CONSTRAINT prim_rendered_services PRIMARY KEY (ID),
	 CONSTRAINT foreign_rendered_services_to_photoshop FOREIGN KEY (photoshop_ID) REFERENCES photoshop (ID),
	 CONSTRAINT foreign_rendered_services_to_additional_services FOREIGN KEY (additional_services_ID) REFERENCES additional_services (ID));

CREATE TABLE supplies
	([ID] SMALLINT IDENTITY(1, 1) NOT NULL,
	 [type] NVARCHAR(50) NOT NULL,
	 CONSTRAINT prim_supplies PRIMARY KEY (ID),
	 CONSTRAINT check_type_supplies CHECK ([type] IN ('фотобумага', 'фотопленка', 'химические реактивы')));

CREATE TABLE order_supplies
	([ID] INT IDENTITY(1, 1) NOT NULL,
	 [supplies_ID] SMALLINT NOT NULL,
	 [quantity] INT NOT NULL,
	 CONSTRAINT prim_order_supplies PRIMARY KEY (ID),
	 CONSTRAINT foreign_order_supplies_to_supplies FOREIGN KEY (supplies_ID) REFERENCES supplies (ID));

CREATE TABLE order_photo_products
	([ID] INT IDENTITY(1, 1) NOT NULL,
	 [photo_products_ID] SMALLINT NOT NULL,
	 [quantity] INT NOT NULL,
	 CONSTRAINT prim_order_photo_products PRIMARY KEY (ID),
	 CONSTRAINT foreign_order_photo_products_to_photo_products FOREIGN KEY (photo_products_ID) REFERENCES photo_products (ID));

CREATE TABLE short_of_resources_branch
	([ID] INT IDENTITY(1, 1) NOT NULL,
	 [date] DATE NOT NULL,
	 [branch_ID] SMALLINT NOT NULL,
	 [supplies_ID] SMALLINT NOT NULL,
	 [quantity] INT NOT NULL,
	 CONSTRAINT prim_short_of_resoursec_branch PRIMARY KEY (ID),
	 CONSTRAINT foreign_short_of_resources_branch_to_branch FOREIGN KEY (branch_ID) REFERENCES branch (ID),
	 CONSTRAINT foreign_short_of_resources_branch_to_supplies FOREIGN KEY (supplies_ID) REFERENCES supplies (ID));

CREATE TABLE short_of_resources_stall
	([ID] INT IDENTITY(1, 1) NOT NULL,
	 [date] DATE NOT NULL,
	 [stall_ID] SMALLINT NOT NULL,
	 [photo_products_ID] SMALLINT NOT NULL,
	 [quantity] INT NOT NULL,
	 CONSTRAINT prim_short_of_resoursec_stall PRIMARY KEY (ID),
	 CONSTRAINT foreign_short_of_resources_stall_to_stall FOREIGN KEY (stall_ID) REFERENCES stall (ID),
	 CONSTRAINT foreign_short_of_resources_stall_to_photo_products FOREIGN KEY (photo_products_ID) REFERENCES photo_products (ID));

CREATE TABLE short_of_resources_photoshop
	([ID] INT IDENTITY(1, 1) NOT NULL,
	 [date] DATE NOT NULL,
	 [photoshop_ID] SMALLINT NOT NULL,
	 [photo_products_ID] SMALLINT NOT NULL,
	 [quantity_photo_products] INT NOT NULL,
	 [supplies_ID] SMALLINT NOT NULL,
	 [quantity_supplies] INT NOT NULL,
	 CONSTRAINT prim_short_of_resoursec_photoshop PRIMARY KEY (ID),
	 CONSTRAINT foreign_short_of_resources_photoshop_to_photoshop FOREIGN KEY (photoshop_ID) REFERENCES photoshop (ID),
	 CONSTRAINT foreign_short_of_resources_photoshop_to_supplies FOREIGN KEY (supplies_ID) REFERENCES supplies (ID),
	 CONSTRAINT foreign_short_of_resources_photoshop_to_photo_products FOREIGN KEY (photo_products_ID) REFERENCES photo_products (ID));

CREATE TABLE suppliers
	([ID] SMALLINT IDENTITY(1, 1) NOT NULL,
	 [trade_name] NVARCHAR(50) NOT NULL,
	 [photo_products_ID] SMALLINT NOT NULL,
	 CONSTRAINT prim_suppliers PRIMARY KEY (ID),
	 CONSTRAINT foreign_suppliers_to_photo_products FOREIGN KEY (photo_products_ID) REFERENCES photo_products (ID));