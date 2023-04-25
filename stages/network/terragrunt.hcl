# include parent terragrunt content to DRY.
include "root"{
  path = find_in_parent_folders()
}