--
-- Database creator for ASN
--

DROP TABLE IF EXISTS asn;

CREATE TABLE asn (
       asn	  INTEGER PRIMARY KEY,
       rir	  TEXT,
       country	  TEXT,
       org	  TEXT
);

.separator |
.import __FILE__ asn
