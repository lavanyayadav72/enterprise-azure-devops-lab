resource "azurerm_storage_management_policy" "this" {

  storage_account_id = azurerm_storage_account.this.id

  rule {

    name = "archive-old-data"

    enabled = true

    filters {

      blob_types = [
        "blockBlob"
      ]

    }

    actions {

      base_blob {

        tier_to_cool_after_days_since_modification_greater_than = 30

        tier_to_archive_after_days_since_modification_greater_than = 90

      }

    }

  }


   rule {

    name = "delete-old-temp-files"

    enabled = true

    filters {

        prefix_match = [
        "temp/"
    ]

    blob_types = [
      "blockBlob"
    ]

  }

  actions {

    base_blob {

      delete_after_days_since_modification_greater_than = 30

    }

  }
}
}