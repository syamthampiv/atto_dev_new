DROP VIEW v_follow;

DROP TABLE accreditation;

CREATE TABLE accreditation
(
  id uuid NOT NULL,
  status character varying,
  country character varying(20),
  approver_id uuid,
  requester_id uuid,
  notes character varying(20),
  product_category json,
  provider_id uuid,
  operation_area json,
  CONSTRAINT pk_accredition PRIMARY KEY (id)
);

