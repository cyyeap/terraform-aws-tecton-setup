resource "random_id" "external_id" {
  count = local.has_cross_account_external_id ? 0 : 1

  byte_length = 16
}
