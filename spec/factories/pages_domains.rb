# frozen_string_literal: true

FactoryBot.define do
  factory :pages_domain, class: 'PagesDomain' do
    sequence(:domain) { |n| "my#{n}.domain.com" }
    verified_at { Time.now }
    enabled_until { 1.week.from_now }

    certificate do
      File.read(Rails.root.join('spec/fixtures/', 'ssl_certificate.pem'))
    end

    key do
      File.read(Rails.root.join('spec/fixtures/', 'ssl_key.pem'))
    end

    trait :disabled do
      verified_at { nil }
      enabled_until { nil }
    end

    trait :scheduled_for_removal do
      remove_at { 1.day.from_now }
    end

    trait :should_be_removed do
      remove_at { 1.day.ago }
    end

    trait :unverified do
      verified_at { nil }
    end

    trait :reverify do
      enabled_until { 1.hour.from_now }
    end

    trait :expired do
      enabled_until { 1.hour.ago }
    end

    trait :without_certificate do
      certificate { nil }
    end

    trait :without_key do
      key { nil }
    end

    trait :with_missing_chain do
      # This certificate is signed with different key
      # And misses the CA to build trust chain
      certificate do
        '-----BEGIN CERTIFICATE-----
MIIDGTCCAgGgAwIBAgIBAjANBgkqhkiG9w0BAQUFADASMRAwDgYDVQQDEwdUZXN0
IENBMB4XDTE2MDIxMjE0MjMwMFoXDTE3MDIxMTE0MjMwMFowHTEbMBkGA1UEAxMS
dGVzdC1jZXJ0aWZpY2F0ZS0yMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAw8RWetIUT0YymSuKvBpClzDv/jQdX0Ch+2iF7f4Lm3lcmoUuXgyhl/WRe5K9
ONuMHPQlZbeavEbvWb0BsU7geInhsjd/zAu3EP17jfSIXToUdSD20wcSG/yclLdZ
qhb6NCtHTJKFUI8BktoS7kafkdvmeem/UJFzlvcA6VMyGDkS8ZN39a45R1jGmPEl
Yk0g1jW7lSKcBLjU1O/Csv59LyWXqBP6jR1vB8ijlUf1IyK8gOk7NHF13GHl7Z3A
/8zwuEt/pB3yK92o71P+FnSEcJ23zcAalz6H9ajVTzRr/AXttineBNVYnEuPXW+V
Rsboe+bBO/e4pVKXnQ1F3aMT7QIDAQABo28wbTAMBgNVHRMBAf8EAjAAMB0GA1Ud
DgQWBBSFwo3rhc26lD8ZVaBVcUY1NyCOLDALBgNVHQ8EBAMCBeAwEQYJYIZIAYb4
QgEBBAQDAgZAMB4GCWCGSAGG+EIBDQQRFg94Y2EgY2VydGlmaWNhdGUwDQYJKoZI
hvcNAQEFBQADggEBABppUhunuT7qArM9gZ2gLgcOK8qyZWU8AJulvloaCZDvqGVs
Qom0iEMBrrt5+8bBevNiB49Tz7ok8NFgLzrlEnOw6y6QGjiI/g8sRKEiXl+ZNX8h
s8VN6arqT348OU8h2BixaXDmBF/IqZVApGhR8+B4fkCt0VQmdzVuHGbOQXMWJCpl
WlU8raZoPIqf6H/8JA97pM/nk/3CqCoHsouSQv+jGY4pSL22RqsO0ylIM0LDBbmF
m4AEaojTljX1tMJAF9Rbiw/omam5bDPq2JWtosrz/zB69y5FaQjc6FnCk0M4oN/+
VM+d42lQAgoq318A84Xu5vRh1KCAJuztkhNbM+w=
-----END CERTIFICATE-----'
      end
    end

    trait :with_trusted_chain do
      # This contains
      # [Intermediate #2 (SHA-2)] 'Comodo RSA Domain Validation Secure Server CA'
      # [Intermediate #1 (SHA-2)] 'COMODO RSA Certification Authority'
      certificate do
        '-----BEGIN CERTIFICATE-----
MIIGCDCCA/CgAwIBAgIQKy5u6tl1NmwUim7bo3yMBzANBgkqhkiG9w0BAQwFADCB
hTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
A1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxKzApBgNV
BAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTQwMjEy
MDAwMDAwWhcNMjkwMjExMjM1OTU5WjCBkDELMAkGA1UEBhMCR0IxGzAZBgNVBAgT
EkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMR
Q09NT0RPIENBIExpbWl0ZWQxNjA0BgNVBAMTLUNPTU9ETyBSU0EgRG9tYWluIFZh
bGlkYXRpb24gU2VjdXJlIFNlcnZlciBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEP
ADCCAQoCggEBAI7CAhnhoFmk6zg1jSz9AdDTScBkxwtiBUUWOqigwAwCfx3M28Sh
bXcDow+G+eMGnD4LgYqbSRutA776S9uMIO3Vzl5ljj4Nr0zCsLdFXlIvNN5IJGS0
Qa4Al/e+Z96e0HqnU4A7fK31llVvl0cKfIWLIpeNs4TgllfQcBhglo/uLQeTnaG6
ytHNe+nEKpooIZFNb5JPJaXyejXdJtxGpdCsWTWM/06RQ1A/WZMebFEh7lgUq/51
UHg+TLAchhP6a5i84DuUHoVS3AOTJBhuyydRReZw3iVDpA3hSqXttn7IzW3uLh0n
c13cRTCAquOyQQuvvUSH2rnlG51/ruWFgqUCAwEAAaOCAWUwggFhMB8GA1UdIwQY
MBaAFLuvfgI9+qbxPISOre44mOzZMjLUMB0GA1UdDgQWBBSQr2o6lFoL2JDqElZz
30O0Oija5zAOBgNVHQ8BAf8EBAMCAYYwEgYDVR0TAQH/BAgwBgEB/wIBADAdBgNV
HSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIwGwYDVR0gBBQwEjAGBgRVHSAAMAgG
BmeBDAECATBMBgNVHR8ERTBDMEGgP6A9hjtodHRwOi8vY3JsLmNvbW9kb2NhLmNv
bS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDBxBggrBgEFBQcB
AQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9E
T1JTQUFkZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21v
ZG9jYS5jb20wDQYJKoZIhvcNAQEMBQADggIBAE4rdk+SHGI2ibp3wScF9BzWRJ2p
mj6q1WZmAT7qSeaiNbz69t2Vjpk1mA42GHWx3d1Qcnyu3HeIzg/3kCDKo2cuH1Z/
e+FE6kKVxF0NAVBGFfKBiVlsit2M8RKhjTpCipj4SzR7JzsItG8kO3KdY3RYPBps
P0/HEZrIqPW1N+8QRcZs2eBelSaz662jue5/DJpmNXMyYE7l3YphLG5SEXdoltMY
dVEVABt0iN3hxzgEQyjpFv3ZBdRdRydg1vs4O2xyopT4Qhrf7W8GjEXCBgCq5Ojc
2bXhc3js9iPc0d1sjhqPpepUfJa3w/5Vjo1JXvxku88+vZbrac2/4EjxYoIQ5QxG
V/Iz2tDIY+3GH5QFlkoakdH368+PUq4NCNk+qKBR6cGHdNXJ93SrLlP7u3r7l+L4
HyaPs9Kg4DdbKDsx5Q5XLVq4rXmsXiBmGqW5prU5wfWYQ//u+aen/e7KJD2AFsQX
j4rBYKEMrltDR5FL1ZoXX/nUh8HCjLfn4g8wGTeGrODcQgPmlKidrv0PJFGUzpII
0fxQ8ANAe4hZ7Q7drNJ3gjTcBpUC2JD5Leo31Rpg0Gcg19hCC0Wvgmje3WYkN5Ap
lBlGGSW4gNfL1IYoakRwJiNiqZ+Gb7+6kHDSVneFeO/qJakXzlByjAA6quPbYzSf
+AZxAeKCINT+b72x
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIF2DCCA8CgAwIBAgIQTKr5yttjb+Af907YWwOGnTANBgkqhkiG9w0BAQwFADCB
hTELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4G
A1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxKzApBgNV
BAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkwHhcNMTAwMTE5
MDAwMDAwWhcNMzgwMTE4MjM1OTU5WjCBhTELMAkGA1UEBhMCR0IxGzAZBgNVBAgT
EkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMR
Q09NT0RPIENBIExpbWl0ZWQxKzApBgNVBAMTIkNPTU9ETyBSU0EgQ2VydGlmaWNh
dGlvbiBBdXRob3JpdHkwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCR
6FSS0gpWsawNJN3Fz0RndJkrN6N9I3AAcbxT38T6KhKPS38QVr2fcHK3YX/JSw8X
pz3jsARh7v8Rl8f0hj4K+j5c+ZPmNHrZFGvnnLOFoIJ6dq9xkNfs/Q36nGz637CC
9BR++b7Epi9Pf5l/tfxnQ3K9DADWietrLNPtj5gcFKt+5eNu/Nio5JIk2kNrYrhV
/erBvGy2i/MOjZrkm2xpmfh4SDBF1a3hDTxFYPwyllEnvGfDyi62a+pGx8cgoLEf
Zd5ICLqkTqnyg0Y3hOvozIFIQ2dOciqbXL1MGyiKXCJ7tKuY2e7gUYPDCUZObT6Z
+pUX2nwzV0E8jVHtC7ZcryxjGt9XyD+86V3Em69FmeKjWiS0uqlWPc9vqv9JWL7w
qP/0uK3pN/u6uPQLOvnoQ0IeidiEyxPx2bvhiWC4jChWrBQdnArncevPDt09qZah
SL0896+1DSJMwBGB7FY79tOi4lu3sgQiUpWAk2nojkxl8ZEDLXB0AuqLZxUpaVIC
u9ffUGpVRr+goyhhf3DQw6KqLCGqR84onAZFdr+CGCe01a60y1Dma/RMhnEw6abf
Fobg2P9A3fvQQoh/ozM6LlweQRGBY84YcWsr7KaKtzFcOmpH4MN5WdYgGq/yapiq
crxXStJLnbsQ/LBMQeXtHT1eKJ2czL+zUdqnR+WEUwIDAQABo0IwQDAdBgNVHQ4E
FgQUu69+Aj36pvE8hI6t7jiY7NkyMtQwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB
/wQFMAMBAf8wDQYJKoZIhvcNAQEMBQADggIBAArx1UaEt65Ru2yyTUEUAJNMnMvl
wFTPoCWOAvn9sKIN9SCYPBMtrFaisNZ+EZLpLrqeLppysb0ZRGxhNaKatBYSaVqM
4dc+pBroLwP0rmEdEBsqpIt6xf4FpuHA1sj+nq6PK7o9mfjYcwlYRm6mnPTXJ9OV
2jeDchzTc+CiR5kDOF3VSXkAKRzH7JsgHAckaVd4sjn8OoSgtZx8jb8uk2Intzna
FxiuvTwJaP+EmzzV1gsD41eeFPfR60/IvYcjt7ZJQ3mFXLrrkguhxuhoqEwWsRqZ
CuhTLJK7oQkYdQxlqHvLI7cawiiFwxv/0Cti76R7CZGYZ4wUAc1oBmpjIXUDgIiK
boHGhfKppC3n9KUkEEeDys30jXlYsQab5xoq2Z0B15R97QNKyvDb6KkBPvVWmcke
jkk9u+UJueBPSZI9FoJAzMxZxuY67RIuaTxslbH9qh17f4a+Hg4yRvv7E491f0yL
S0Zj/gA0QHDBw7mh3aZw4gSzQbzpgJHqZJx64SIDqZxubw5lT2yHh17zbqD5daWb
QOhTsiedSrnAdyGN/4fy3ryM7xfft0kL0fJuMAsaDk527RH89elWsn2/x20Kk4yl
0MC2Hb46TpSi125sC8KKfPog88Tk5c0NqMuRkrF8hey1FGlmDoLnzc7ILaZRfyHB
NVOFBkpdn627G190
-----END CERTIFICATE-----'
      end
    end

    trait :with_trusted_expired_chain do
      # This contains
      # Let's Encrypt Authority X3
      # DST Root CA X3
      certificate do
        '-----BEGIN CERTIFICATE-----
MIIFSjCCBDKgAwIBAgISAw24xGWrFotvTBa6AZI/pzq1MA0GCSqGSIb3DQEBCwUA
MEoxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MSMwIQYDVQQD
ExpMZXQncyBFbmNyeXB0IEF1dGhvcml0eSBYMzAeFw0xOTAzMDcxNzU5NTZaFw0x
OTA2MDUxNzU5NTZaMBQxEjAQBgNVBAMTCXN5dHNlLmNvbTCCASIwDQYJKoZIhvcN
AQEBBQADggEPADCCAQoCggEBALtIpQuqeZN6OgEE+y2UoGC/31Vt9NAeQWvTuWWO
nMn/MvDJiw8731Dx4DDbMjhF50UBE20a9iAu2nhlxcsuuIITk2MXKMEgPtqSbwM7
Mg0/WvgrBOWnF9CpdD3qcsjtstT6Djij06VfMfUrRZzMkGgbGzudR0cShKPmkBVU
LgB6crFmSQ/qHt5PzBivdexCUpz5WzSKU5UWYFx2UnkSLykvEJuUr3Nn4/o9oyKw
Qoiq354S262mFuMW+s6wQdMNNkwj41OqCwAGbqq7YUYLDc8OQiRC2LcqSO5yYnnA
0lNfbEatZ1BzHiDjTH7wMUtwcLGHsZ1C5ZmORD2s2gtGiRkCAwEAAaOCAl4wggJa
MA4GA1UdDwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDAQYIKwYBBQUHAwIw
DAYDVR0TAQH/BAIwADAdBgNVHQ4EFgQUAMn3t1s4zXdOQbJFOP1riSwjuGkwHwYD
VR0jBBgwFoAUqEpqYwR93brm0Tm3pkVl7/Oo7KEwbwYIKwYBBQUHAQEEYzBhMC4G
CCsGAQUFBzABhiJodHRwOi8vb2NzcC5pbnQteDMubGV0c2VuY3J5cHQub3JnMC8G
CCsGAQUFBzAChiNodHRwOi8vY2VydC5pbnQteDMubGV0c2VuY3J5cHQub3JnLzAU
BgNVHREEDTALgglzeXRzZS5jb20wTAYDVR0gBEUwQzAIBgZngQwBAgEwNwYLKwYB
BAGC3xMBAQEwKDAmBggrBgEFBQcCARYaaHR0cDovL2Nwcy5sZXRzZW5jcnlwdC5v
cmcwggEEBgorBgEEAdZ5AgQCBIH1BIHyAPAAdQB0ftqDMa0zEJEhnM4lT0Jwwr/9
XkIgCMY3NXnmEHvMVgAAAWlZhr4pAAAEAwBGMEQCIBEA+3oiM1UJKY1kajBO5Aoz
9AZMMlImaR1X5hFIPr95AiBXGIACuXUDLchB0kT8VIG/jM4f9iuXMoYCoKNJggNM
/gB3ACk8UZZUyDlluqpQ/FgH1Ldvv1h6KXLcpMMM9OVFR/R4AAABaVmGv/AAAAQD
AEgwRgIhANeTA7H51SZUmcT2ldtumFYX6/OkOr0fdvze72U0j9U9AiEAjSOSVQmi
ZdYK6u3JYkDVOWsEzyKwjPWod8UN5K3ej0EwDQYJKoZIhvcNAQELBQADggEBAJev
ArtxZVVTmLghV0O7471J1mN1fVC2p6b3AsK/TqrI7aiq8XuQq76KmUsB+U05MTXH
3sYiHm+/RJ7+ljiKVIC8ZfbQsHo5I+F1CNMo6JB6z8Z+bOeRkoves5FNYmiJnUjO
uoGzt//CyldbX1dEPVNuU7P0s2wZ6Bubump2LoapGIiGxQJfeb0vj0TQzfRacTIZ
x9U5E/D0y0iewX4kPHK17QDBsSL9WlqsRzFAkQjJ9XWUVn3BO7JG3WU47iOuykby
y2HmOWUxjv1Yf/H/OYRBiuSCR4LhrE5Ze4tTo2AByrXQ5h7ezjDJQqnKBP5NuwIq
7NuX+D2esUNos/D6uJg=
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIEkjCCA3qgAwIBAgIQCgFBQgAAAVOFc2oLheynCDANBgkqhkiG9w0BAQsFADA/
MSQwIgYDVQQKExtEaWdpdGFsIFNpZ25hdHVyZSBUcnVzdCBDby4xFzAVBgNVBAMT
DkRTVCBSb290IENBIFgzMB4XDTE2MDMxNzE2NDA0NloXDTIxMDMxNzE2NDA0Nlow
SjELMAkGA1UEBhMCVVMxFjAUBgNVBAoTDUxldCdzIEVuY3J5cHQxIzAhBgNVBAMT
GkxldCdzIEVuY3J5cHQgQXV0aG9yaXR5IFgzMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAnNMM8FrlLke3cl03g7NoYzDq1zUmGSXhvb418XCSL7e4S0EF
q6meNQhY7LEqxGiHC6PjdeTm86dicbp5gWAf15Gan/PQeGdxyGkOlZHP/uaZ6WA8
SMx+yk13EiSdRxta67nsHjcAHJyse6cF6s5K671B5TaYucv9bTyWaN8jKkKQDIZ0
Z8h/pZq4UmEUEz9l6YKHy9v6Dlb2honzhT+Xhq+w3Brvaw2VFn3EK6BlspkENnWA
a6xK8xuQSXgvopZPKiAlKQTGdMDQMc2PMTiVFrqoM7hD8bEfwzB/onkxEz0tNvjj
/PIzark5McWvxI0NHWQWM6r6hCm21AvA2H3DkwIDAQABo4IBfTCCAXkwEgYDVR0T
AQH/BAgwBgEB/wIBADAOBgNVHQ8BAf8EBAMCAYYwfwYIKwYBBQUHAQEEczBxMDIG
CCsGAQUFBzABhiZodHRwOi8vaXNyZy50cnVzdGlkLm9jc3AuaWRlbnRydXN0LmNv
bTA7BggrBgEFBQcwAoYvaHR0cDovL2FwcHMuaWRlbnRydXN0LmNvbS9yb290cy9k
c3Ryb290Y2F4My5wN2MwHwYDVR0jBBgwFoAUxKexpHsscfrb4UuQdf/EFWCFiRAw
VAYDVR0gBE0wSzAIBgZngQwBAgEwPwYLKwYBBAGC3xMBAQEwMDAuBggrBgEFBQcC
ARYiaHR0cDovL2Nwcy5yb290LXgxLmxldHNlbmNyeXB0Lm9yZzA8BgNVHR8ENTAz
MDGgL6AthitodHRwOi8vY3JsLmlkZW50cnVzdC5jb20vRFNUUk9PVENBWDNDUkwu
Y3JsMB0GA1UdDgQWBBSoSmpjBH3duubRObemRWXv86jsoTANBgkqhkiG9w0BAQsF
AAOCAQEA3TPXEfNjWDjdGBX7CVW+dla5cEilaUcne8IkCJLxWh9KEik3JHRRHGJo
uM2VcGfl96S8TihRzZvoroed6ti6WqEBmtzw3Wodatg+VyOeph4EYpr/1wXKtx8/
wApIvJSwtmVi4MFU5aMqrSDE6ea73Mj2tcMyo5jMd6jmeWUHK8so/joWUoHOUgwu
X4Po1QYz+3dszkDqMp4fklxBwXRsW10KXzPMTZ+sOPAveyxindmjkW8lGy+QsRlG
PfZ+G6Z6h7mjem0Y+iWlkYcV4PIWL1iwBi8saCbGS5jN2p8M+X+Q7UNKEkROb3N6
KOqkqm57TH2H3eDJAkSnh6/DNFu0Qg==
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
MIIDSjCCAjKgAwIBAgIQRK+wgNajJ7qJMDmGLvhAazANBgkqhkiG9w0BAQUFADA/
MSQwIgYDVQQKExtEaWdpdGFsIFNpZ25hdHVyZSBUcnVzdCBDby4xFzAVBgNVBAMT
DkRTVCBSb290IENBIFgzMB4XDTAwMDkzMDIxMTIxOVoXDTIxMDkzMDE0MDExNVow
PzEkMCIGA1UEChMbRGlnaXRhbCBTaWduYXR1cmUgVHJ1c3QgQ28uMRcwFQYDVQQD
Ew5EU1QgUm9vdCBDQSBYMzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AN+v6ZdQCINXtMxiZfaQguzH0yxrMMpb7NnDfcdAwRgUi+DoM3ZJKuM/IUmTrE4O
rz5Iy2Xu/NMhD2XSKtkyj4zl93ewEnu1lcCJo6m67XMuegwGMoOifooUMM0RoOEq
OLl5CjH9UL2AZd+3UWODyOKIYepLYYHsUmu5ouJLGiifSKOeDNoJjj4XLh7dIN9b
xiqKqy69cK3FCxolkHRyxXtqqzTWMIn/5WgTe1QLyNau7Fqckh49ZLOMxt+/yUFw
7BZy1SbsOFU5Q9D8/RhcQPGX69Wam40dutolucbY38EVAjqr2m7xPi71XAicPNaD
aeQQmxkqtilX4+U9m5/wAl0CAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAOBgNV
HQ8BAf8EBAMCAQYwHQYDVR0OBBYEFMSnsaR7LHH62+FLkHX/xBVghYkQMA0GCSqG
SIb3DQEBBQUAA4IBAQCjGiybFwBcqR7uKGY3Or+Dxz9LwwmglSBd49lZRNI+DT69
ikugdB/OEIKcdBodfpga3csTS7MgROSR6cz8faXbauX+5v3gTt23ADq1cEmv8uXr
AvHRAosZy5Q6XkjEGB5YGV8eAlrwDPGxrancWYaLbumR9YbK+rlmM6pZW87ipxZz
R8srzJmwN0jP41ZL9c8PDHIyh8bwRLtTcm1D9SZImlJnt1ir/md2cXjbDaJWFBM5
JDGFoqgCWjBH4d1QB7wCCZAA62RjYJsWvIjJEubSfZGL+T0yjWW06XyxV3bqxbYo
Ob8VZRzI9neWagqNdwvYkQsEjgfbKbYK7p2CNTUQ
-----END CERTIFICATE-----'
      end
    end

    trait :with_expired_certificate do
      certificate do
        '-----BEGIN CERTIFICATE-----
MIIBsDCCARmgAwIBAgIBATANBgkqhkiG9w0BAQUFADAeMRwwGgYDVQQDExNleHBp
cmVkLWNlcnRpZmljYXRlMB4XDTE1MDIxMjE0MzMwMFoXDTE2MDIwMTE0MzMwMFow
HjEcMBoGA1UEAxMTZXhwaXJlZC1jZXJ0aWZpY2F0ZTCBnzANBgkqhkiG9w0BAQEF
AAOBjQAwgYkCgYEApL4J9L0ZxFJ1hI1LPIflAlAGvm6ZEvoT4qKU5Xf2JgU7/2ge
NR1qlNFaSvCc08Knupp5yTgmvyK/Xi09U0N82vvp4Zvr/diSc4A/RA6Mta6egLyS
NT438kdTnY2tR5feoTLwQpX0t4IMlwGQGT5h6Of2fKmDxzuwuyffcIHqLdsCAwEA
ATANBgkqhkiG9w0BAQUFAAOBgQBNj+vWvneyW1KkbVK+b/cVmnYPSfbkHrYK6m8X
Hq9LkWn6WP4EHsesHyslgTQZF8C7kVLTbLn2noLnOE+Mp3vcWlZxl3Yk6aZMhKS+
Iy6oRpHaCF/2obZdIdgf9rlyz0fkqyHJc9GkioSoOhJZxEV2SgAkap8yS0sX2tJ9
ZDXgrA==
-----END CERTIFICATE-----'
      end
    end

    trait :letsencrypt do
      auto_ssl_enabled { true }
      certificate_source { :gitlab_provided }
    end

    # This contains:
    # webdioxide.com
    # Let's Encrypt R3
    # ISRG Root X1 (issued by DST Root CA X3)
    #
    # DST Root CA X3 expired on 2021-09-30, but ISRG Root X1 should be trusted on most systems.
    trait :letsencrypt_expired_x3_root do
      certificate do
        File.read(Rails.root.join('spec/fixtures/ssl', 'letsencrypt_expired_x3.pem'))
      end
    end

    trait :explicit_ecdsa do
      certificate do
        '-----BEGIN CERTIFICATE-----
MIID1zCCAzkCCQDatOIwBlktwjAKBggqhkjOPQQDAjBPMQswCQYDVQQGEwJVUzEL
MAkGA1UECAwCTlkxCzAJBgNVBAcMAk5ZMQswCQYDVQQLDAJJVDEZMBcGA1UEAwwQ
dGVzdC1jZXJ0aWZpY2F0ZTAeFw0xOTA4MjkxMTE1NDBaFw0yMTA4MjgxMTE1NDBa
ME8xCzAJBgNVBAYTAlVTMQswCQYDVQQIDAJOWTELMAkGA1UEBwwCTlkxCzAJBgNV
BAsMAklUMRkwFwYDVQQDDBB0ZXN0LWNlcnRpZmljYXRlMIICXDCCAc8GByqGSM49
AgEwggHCAgEBME0GByqGSM49AQECQgH/////////////////////////////////
/////////////////////////////////////////////////////zCBngRCAf//
////////////////////////////////////////////////////////////////
///////////////////8BEFRlT65YY4cmh+SmiGgtoVA7qLacluZsxXzuLSJkY7x
CeFWGTlR7H6TexZSwL07sb8HNXPfiD0sNPHvRR/Ua1A/AAMVANCeiAApHLhTlsxn
FzkyhKqg2mS6BIGFBADGhY4GtwQE6c2ePstmI5W0QpxkgTkFP7Uh+CivYGtNPbqh
S1537+dZKP4dwSei/6jeM0izwYVqQpv5fn4xwuW9ZgEYOSlqeJo7wARcil+0LH0b
2Zj1RElXm0RoF6+9Fyc+ZiyX7nKZXvQmQMVQuQE/rQdhNTxwhqJywkCIvpR2n9Fm
UAJCAf//////////////////////////////////////////+lGGh4O/L5Zrf8wB
SPcJpdA7tcm4iZxHrrtvtx6ROGQJAgEBA4GGAAQBVG/4c/hgl36toHj+eGL4pqv7
l7M+ZKQJ4vz0Y9E6xIx+gvfVaZ58krmbBAP53ikwneQbFdcvw3L/ACPEib/qWjkB
ogykguy3OwHtKLYNnDWIsfiLumEjElhcBMZVXiXhb5txf11uXAWn5n6Qhey5YKPM
NjLLqDqaG19efCLCd21A0TcwCgYIKoZIzj0EAwIDgYsAMIGHAkEm68kYFVnN1c2N
OjSJpIDdFWGVYJHyMDI5WgQyhm4hAioXJ0T22Zab8Wmq+hBYRJNcHoaV894blfqR
V3ZJgam8EQJCAcnPpJQ0IqoT1pAQkaL3+Ka8ZaaCd6/8RnoDtGvWljisuyH65SRu
kmYv87bZe1KqOZDoaDBdfVsoxcGbik19lBPV
-----END CERTIFICATE-----'
      end

      key do
        '-----BEGIN EC PARAMETERS-----
MIIBwgIBATBNBgcqhkjOPQEBAkIB////////////////////////////////////
//////////////////////////////////////////////////8wgZ4EQgH/////
////////////////////////////////////////////////////////////////
/////////////////ARBUZU+uWGOHJofkpohoLaFQO6i2nJbmbMV87i0iZGO8Qnh
Vhk5Uex+k3sWUsC9O7G/BzVz34g9LDTx70Uf1GtQPwADFQDQnogAKRy4U5bMZxc5
MoSqoNpkugSBhQQAxoWOBrcEBOnNnj7LZiOVtEKcZIE5BT+1Ifgor2BrTT26oUte
d+/nWSj+HcEnov+o3jNIs8GFakKb+X5+McLlvWYBGDkpaniaO8AEXIpftCx9G9mY
9URJV5tEaBevvRcnPmYsl+5ymV70JkDFULkBP60HYTU8cIaicsJAiL6Udp/RZlAC
QgH///////////////////////////////////////////pRhoeDvy+Wa3/MAUj3
CaXQO7XJuImcR667b7cekThkCQIBAQ==
-----END EC PARAMETERS-----
-----BEGIN EC PRIVATE KEY-----
MIICnQIBAQRCAZZRG4FJO+OK29ygycrNzjxQDB+dp+QPo1Pk6RAl5PcraohyhFnI
MGUL4ba1efZUxCbAWxjVRSi7QEUNYCCdUPAtoIIBxjCCAcICAQEwTQYHKoZIzj0B
AQJCAf//////////////////////////////////////////////////////////
////////////////////////////MIGeBEIB////////////////////////////
//////////////////////////////////////////////////////////wEQVGV
PrlhjhyaH5KaIaC2hUDuotpyW5mzFfO4tImRjvEJ4VYZOVHsfpN7FlLAvTuxvwc1
c9+IPSw08e9FH9RrUD8AAxUA0J6IACkcuFOWzGcXOTKEqqDaZLoEgYUEAMaFjga3
BATpzZ4+y2YjlbRCnGSBOQU/tSH4KK9ga009uqFLXnfv51ko/h3BJ6L/qN4zSLPB
hWpCm/l+fjHC5b1mARg5KWp4mjvABFyKX7QsfRvZmPVESVebRGgXr70XJz5mLJfu
cple9CZAxVC5AT+tB2E1PHCGonLCQIi+lHaf0WZQAkIB////////////////////
///////////////////////6UYaHg78vlmt/zAFI9wml0Du1ybiJnEeuu2+3HpE4
ZAkCAQGhgYkDgYYABAFUb/hz+GCXfq2geP54Yvimq/uXsz5kpAni/PRj0TrEjH6C
99VpnnySuZsEA/neKTCd5BsV1y/Dcv8AI8SJv+paOQGiDKSC7Lc7Ae0otg2cNYix
+Iu6YSMSWFwExlVeJeFvm3F/XW5cBafmfpCF7Llgo8w2MsuoOpobX158IsJ3bUDR
Nw==
-----END EC PRIVATE KEY-----'
      end
    end

    trait :ecdsa do
      certificate do
        '-----BEGIN CERTIFICATE-----
MIIB8zCCAVUCCQCGKuPQ6SBxUTAKBggqhkjOPQQDAjA+MQswCQYDVQQGEwJVUzEL
MAkGA1UECAwCVVMxCzAJBgNVBAcMAlVTMRUwEwYDVQQDDAxzaHVzaGxpbi5kZXYw
HhcNMTkwOTAyMDkyMDUxWhcNMjEwOTAxMDkyMDUxWjA+MQswCQYDVQQGEwJVUzEL
MAkGA1UECAwCVVMxCzAJBgNVBAcMAlVTMRUwEwYDVQQDDAxzaHVzaGxpbi5kZXYw
gZswEAYHKoZIzj0CAQYFK4EEACMDgYYABAH9Jd7ZWnTasgltZRbIMreihycOh/G4
TXpkp8tTtEsuD+sh8au3Jywsi89RSZ6vgVoCY7//DQ2vamYnyBZqbL+cTQBsQ7wD
UEaSyP0R3P4b6Ox347pYzXwSdSOra9Cm4TMQe+prVMesxulqIm7G7CTI+9J8LHlJ
z0wUDQz/o+tUSYwv6zAKBggqhkjOPQQDAgOBiwAwgYcCQUOlTnn2QP/uYSh1dUSl
R9WYUg5+PQMg7kS+4K/5+5gonWCvaMcP+2P7hltUcvq41l3uMKKCZRU/x60/FMHc
1ZXdAkIBuVtm9RJXziNOKS4TcpH9os/FuREW8YQlpec58LDZdlivcHnikHZ4LCri
T7zu3VY6Rq+V/IKpsQwQjmoTJ0IpCM8=
-----END CERTIFICATE-----'
      end

      key do
        '-----BEGIN EC PARAMETERS-----
BgUrgQQAIw==
-----END EC PARAMETERS-----
-----BEGIN EC PRIVATE KEY-----
MIHbAgEBBEFa72+eREW25IHbke0TiWFdW1R1ad9Nyqaz7CDtv5Kqdgd6Kcl8V2az
Lr6z1PS+JSERWzRP+fps7kdFRrtqy/ECpKAHBgUrgQQAI6GBiQOBhgAEAf0l3tla
dNqyCW1lFsgyt6KHJw6H8bhNemSny1O0Sy4P6yHxq7cnLCyLz1FJnq+BWgJjv/8N
Da9qZifIFmpsv5xNAGxDvANQRpLI/RHc/hvo7HfjuljNfBJ1I6tr0KbhMxB76mtU
x6zG6WoibsbsJMj70nwseUnPTBQNDP+j61RJjC/r
-----END EC PRIVATE KEY-----'
      end
    end

    trait :instance_serverless do
      wildcard { true }
      scope { :instance }
      usage { :serverless }
    end

    trait :with_project do
      association :project
    end
  end
end
