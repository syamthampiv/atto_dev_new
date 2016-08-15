CREATE OR REPLACE VIEW v_follow AS 
 SELECT a.follower_id AS source_id,
    b.first_name AS source_name,
    f.file_name AS source_icon_path,
    a.follower_entity_type AS source_type,
    'Admin'::text AS source_user,
    c.location AS source_location,
    d.id AS targer_id,
    d.name AS target_name,
    g.file_name AS target_icon_path,
    a.following_entity_type AS target_type,
    h.id AS target_user_id,
    a.id AS follow_id,
    d.product_desc AS product_description,
    'FOLLOW_PRODUCT'::text AS activity_type,
    NULL::uuid AS accreditation_id,
    c.id AS source_company_id,
    e.id AS target_company_id
   FROM follow a
     LEFT JOIN users b ON a.follower_id = b.id
     LEFT JOIN company c ON b.company_id = c.id
     LEFT JOIN products d ON a.following_id = d.id
     LEFT JOIN company e ON d.company_id = e.id
     LEFT JOIN assets f ON (c.assets -> 'PROFILE_IMAGE'::text) = f.id::character varying::text
     LEFT JOIN assets g ON (d.product_details -> 'MAIN_IMAGE'::text) = g.id::character varying::text
     LEFT JOIN users h ON e.id = h.company_id
     LEFT JOIN user_role i ON h.user_role = i.id
  WHERE lower(a.follower_entity_type::text) = 'user'::text AND lower(a.following_entity_type::text) = 'product'::text AND upper(i.name::text) = 'ADMINISTRATOR'::text
UNION ALL
 SELECT a.follower_id AS source_id,
    b.first_name AS source_name,
    f.file_name AS source_icon_path,
    a.follower_entity_type AS source_type,
    'Admin'::text AS source_user,
    c.location AS source_location,
    a.following_id AS targer_id,
    d.name AS target_name,
    g.file_name AS target_icon_path,
    a.following_entity_type AS target_type,
    h.id AS target_user_id,
    a.id AS follow_id,
    NULL::character varying AS product_description,
    'FOLLOW_COMPANY'::text AS activity_type,
    NULL::uuid AS accreditation_id,
    c.id AS source_company_id,
    d.id AS target_company_id
   FROM follow a
     LEFT JOIN users b ON a.follower_id = b.id
     LEFT JOIN company c ON b.company_id = c.id
     LEFT JOIN company d ON a.following_id = d.id
     LEFT JOIN assets f ON (c.assets -> 'PROFILE_IMAGE'::text) = f.id::character varying::text
     LEFT JOIN assets g ON (d.assets -> 'PROFILE_IMAGE'::text) = g.id::character varying::text
     LEFT JOIN users h ON d.id = h.company_id
     LEFT JOIN user_role i ON h.user_role = i.id
  WHERE lower(a.follower_entity_type::text) = 'user'::text AND lower(a.following_entity_type::text) = 'company'::text AND upper(i.name::text) = 'ADMINISTRATOR'::text
UNION ALL
 SELECT c.id AS source_id,
    c.first_name AS source_name,
    f.file_name AS source_icon_path,
    'USER'::character varying AS source_type,
    'Admin'::text AS source_user,
    b.location AS source_location,
    a.id AS targer_id,
    a.name AS target_name,
    g.file_name AS target_icon_path,
    'PRODUCT'::character varying AS target_type,
    c.id AS target_user_id,
    NULL::uuid AS follow_id,
    a.product_desc AS product_description,
    'ADD_PRODUCT'::text AS activity_type,
    NULL::uuid AS accreditation_id,
    b.id AS source_company_id,
    b.id AS target_company_id
   FROM products a
     JOIN company b ON a.company_id = b.id
     JOIN users c ON c.company_id = b.id
     JOIN user_role d ON c.user_role = d.id
     LEFT JOIN assets f ON (b.assets -> 'PROFILE_IMAGE'::text) = f.id::character varying::text
     LEFT JOIN assets g ON (a.product_details -> 'MAIN_IMAGE'::text) = g.id::character varying::text
  WHERE d.name::text = 'ADMINISTRATOR'::text AND COALESCE(a.delete_flag, 'N'::bpchar) = 'N'::bpchar
UNION ALL
 SELECT c.id AS source_id,
    c.first_name AS source_name,
    f.file_name AS source_icon_path,
    'USER'::character varying AS source_type,
    'Admin'::text AS source_user,
    b.location AS source_location,
    a.id AS targer_id,
    a.name AS target_name,
    g.file_name AS target_icon_path,
    'PRODUCT'::character varying AS target_type,
    c.id AS target_user_id,
    NULL::uuid AS follow_id,
    a.product_desc AS product_description,
    'EDIT_PRODUCT'::text AS activity_type,
    NULL::uuid AS accreditation_id,
    b.id AS source_company_id,
    b.id AS target_company_id
   FROM products a
     JOIN company b ON a.company_id = b.id
     JOIN users c ON c.company_id = b.id
     JOIN user_role d ON c.user_role = d.id
     LEFT JOIN assets f ON (b.assets -> 'PROFILE_IMAGE'::text) = f.id::character varying::text
     LEFT JOIN assets g ON (a.product_details -> 'MAIN_IMAGE'::text) = g.id::character varying::text
  WHERE d.name::text = 'ADMINISTRATOR'::text AND COALESCE(a.delete_flag, 'N'::bpchar) = 'N'::bpchar
UNION ALL
 SELECT c.id AS source_id,
    c.first_name AS source_name,
    f.file_name AS source_icon_path,
    'USER'::character varying AS source_type,
    'Admin'::text AS source_user,
    b.location AS source_location,
    a.id AS targer_id,
    a.name AS target_name,
    g.file_name AS target_icon_path,
    'PRODUCT'::character varying AS target_type,
    c.id AS target_user_id,
    NULL::uuid AS follow_id,
    a.product_desc AS product_description,
    'DELETE_PRODUCT'::text AS activity_type,
    NULL::uuid AS accreditation_id,
    b.id AS source_company_id,
    b.id AS target_company_id
   FROM products a
     JOIN company b ON a.company_id = b.id
     JOIN users c ON c.company_id = b.id
     JOIN user_role d ON c.user_role = d.id
     LEFT JOIN assets f ON (b.assets -> 'PROFILE_IMAGE'::text) = f.id::character varying::text
     LEFT JOIN assets g ON (a.product_details -> 'MAIN_IMAGE'::text) = g.id::character varying::text
  WHERE d.name::text = 'ADMINISTRATOR'::text AND COALESCE(a.delete_flag, 'N'::bpchar) = 'Y'::bpchar
UNION ALL
 SELECT a.requester_id AS source_id,
    b.first_name AS source_name,
    f.file_name AS source_icon_path,
    'USER'::character varying AS source_type,
    'Admin'::text AS source_user,
    c.location AS source_location,
    a.provider_id AS targer_id,
    h.name AS target_name,
    j.file_name AS target_icon_path,
    'COMPANY'::character varying AS target_type,
    i.id AS target_user_id,
    NULL::uuid AS follow_id,
    NULL::character varying AS product_description,
    'REQUEST_ACCREDITATION'::text AS activity_type,
    a.id AS accreditation_id,
    c.id AS source_company_id,
    h.id AS target_company_id
   FROM accreditation a
     LEFT JOIN users b ON a.requester_id = b.id
     LEFT JOIN company c ON b.company_id = c.id
     LEFT JOIN user_role d ON b.user_role = d.id
     LEFT JOIN assets f ON (c.assets -> 'PROFILE_IMAGE'::text) = f.id::character varying::text
     LEFT JOIN company h ON a.provider_id = h.id
     LEFT JOIN users i ON i.company_id = h.id
     LEFT JOIN user_role k ON i.user_role = k.id
     LEFT JOIN assets j ON (h.assets -> 'PROFILE_IMAGE'::text) = j.id::character varying::text
  WHERE a.status::text = 'PENDING'::text AND k.name::text = 'ADMINISTRATOR'::text
UNION ALL
 SELECT a.approver_id AS source_id,
    b.first_name AS source_name,
    f.file_name AS source_icon_path,
    'USER'::character varying AS source_type,
    'Admin'::text AS source_user,
    c.location AS source_location,
    a.requester_id AS targer_id,
    g.first_name AS target_name,
    j.file_name AS target_icon_path,
    'USER'::character varying AS target_type,
    a.requester_id AS target_user_id,
    NULL::uuid AS follow_id,
    NULL::character varying AS product_description,
    'APPROVE_ACCREDITATION'::text AS activity_type,
    a.id AS accreditation_id,
    c.id AS source_company_id,
    h.id AS target_company_id
   FROM accreditation a
     LEFT JOIN users b ON a.approver_id = b.id
     LEFT JOIN company c ON b.company_id = c.id
     LEFT JOIN assets f ON (c.assets -> 'PROFILE_IMAGE'::text) = f.id::character varying::text
     LEFT JOIN users g ON a.requester_id = g.id
     LEFT JOIN company h ON g.company_id = h.id
     LEFT JOIN assets j ON (h.assets -> 'PROFILE_IMAGE'::text) = j.id::character varying::text
  WHERE a.status::text = 'APPROVED'::text
UNION ALL
 SELECT a.approver_id AS source_id,
    b.first_name AS source_name,
    f.file_name AS source_icon_path,
    'USER'::character varying AS source_type,
    'Admin'::text AS source_user,
    c.location AS source_location,
    a.requester_id AS targer_id,
    g.first_name AS target_name,
    j.file_name AS target_icon_path,
    'USER'::character varying AS target_type,
    a.requester_id AS target_user_id,
    a.id AS follow_id,
    NULL::character varying AS product_description,
    'REJECT_ACCREDITATION'::text AS activity_type,
    a.id AS accreditation_id,
    c.id AS source_company_id,
    h.id AS target_company_id
   FROM accreditation a
     LEFT JOIN users b ON a.approver_id = b.id
     LEFT JOIN company c ON b.company_id = c.id
     LEFT JOIN assets f ON (c.assets -> 'PROFILE_IMAGE'::text) = f.id::character varying::text
     LEFT JOIN users g ON a.requester_id = g.id
     LEFT JOIN company h ON g.company_id = h.id
     LEFT JOIN assets j ON (h.assets -> 'PROFILE_IMAGE'::text) = j.id::character varying::text
  WHERE a.status::text = 'REJECTED'::text;
