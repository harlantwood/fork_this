# Although technically lower case, they may come in from users as mixed case.
ALPHA_NUMERIC_PATTERN = "a-zA-Z0-9"

MINIMUM_SUBDOMAIN_LENGTH = 8   # This is part of our application logic
MAXIMUM_SUBDOMAIN_LENGTH = 63  # This is a hard limit set by internet standards
DOMAIN_SEGMENT_PATTERN = "[#{ALPHA_NUMERIC_PATTERN}][#{ALPHA_NUMERIC_PATTERN}-]{0,#{MAXIMUM_SUBDOMAIN_LENGTH-1}}"
SUBDOMAIN_PATTERN = "[#{ALPHA_NUMERIC_PATTERN}][#{ALPHA_NUMERIC_PATTERN}-]{#{MINIMUM_SUBDOMAIN_LENGTH-1},#{MAXIMUM_SUBDOMAIN_LENGTH-1}}"

