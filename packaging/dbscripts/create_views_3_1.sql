/**************************************
           VERSIONED VIEWS (3.1)
**************************************/

CREATE OR REPLACE VIEW v3_1_enum_translator_view
 AS
SELECT
    enum_translator.enum_type as enum_type,
    enum_translator.enum_key as enum_key,
    enum_translator.value as value
FROM enum_translator INNER JOIN
            history_configuration ON
                (enum_translator.language_code = history_configuration.var_value
                and history_configuration.var_name = 'default_language');

CREATE OR REPLACE VIEW v3_1_datacenter_configuration_view
 AS
SELECT
      history_id as history_id,
      datacenter_id as datacenter_id,
      datacenter_name as datacenter_name,
      datacenter_description as datacenter_description,
      CASE
          WHEN is_local_storage THEN  CAST(4 AS smallint)
          ELSE CAST(6 AS smallint)
      END as storage_type,
      create_date as create_date,
      update_date as update_date,
      delete_date as delete_date
FROM datacenter_configuration;

CREATE OR REPLACE VIEW v3_1_latest_datacenter_configuration_view
 AS
SELECT
      history_id as history_id,
      datacenter_id as datacenter_id,
      datacenter_name as datacenter_name,
      datacenter_description as datacenter_description,
      CASE
          WHEN is_local_storage THEN  CAST(4 AS smallint)
          ELSE CAST(6 AS smallint)
      END as storage_type,
      create_date as create_date,
      update_date as update_date
FROM datacenter_configuration
WHERE history_id in (SELECT max(a.history_id) FROM datacenter_configuration as a GROUP BY a.datacenter_id)
      and delete_date IS NULL;

CREATE OR REPLACE VIEW v3_1_datacenter_samples_history_view
 AS
SELECT
      history_id as history_id,
      history_datetime as history_datetime,
      datacenter_id as datacenter_id,
      datacenter_status as datacenter_status,
      minutes_in_status as minutes_in_status,
      datacenter_configuration_version as datacenter_configuration_version
FROM datacenter_samples_history;

CREATE OR REPLACE VIEW v3_1_datacenter_hourly_history_view
 AS
SELECT
      history_id as history_id,
      history_datetime as history_datetime,
      datacenter_id as datacenter_id,
      datacenter_status as datacenter_status,
      minutes_in_status as minutes_in_status,
      datacenter_configuration_version as datacenter_configuration_version
FROM datacenter_hourly_history;

CREATE OR REPLACE VIEW v3_1_datacenter_daily_history_view
 AS
SELECT
      history_id as history_id,
      history_datetime as history_datetime,
      datacenter_id as datacenter_id,
      datacenter_status as datacenter_status,
      minutes_in_status as minutes_in_status,
      datacenter_configuration_version as datacenter_configuration_version
FROM datacenter_daily_history;

CREATE OR REPLACE VIEW v3_1_datacenter_storage_domain_map_view
 AS
SELECT
    history_id as history_id,
    storage_domain_id as storage_domain_id,
    datacenter_id as datacenter_id,
    attach_date as attach_date,
    detach_date as detach_date
FROM         datacenter_storage_domain_map;

CREATE OR REPLACE VIEW v3_1_latest_datacenter_storage_domain_map_view
 AS
SELECT
    history_id as history_id,
    storage_domain_id as storage_domain_id,
    datacenter_id as datacenter_id,
    attach_date as attach_date
FROM         datacenter_storage_domain_map
WHERE history_id in (SELECT max(a.history_id) FROM datacenter_storage_domain_map as a GROUP BY a.storage_domain_id, a.datacenter_id)
      and detach_date IS NULL;

CREATE OR REPLACE VIEW v3_1_storage_domain_configuration_view
 AS
SELECT
      history_id as history_id,
      storage_domain_id as storage_domain_id,
      storage_domain_name as storage_domain_name,
      storage_domain_type as storage_domain_type,
      storage_type as storage_type,
      create_date as create_date,
      update_date as update_date,
      delete_date as delete_date
FROM storage_domain_configuration;

CREATE OR REPLACE VIEW v3_1_latest_storage_domain_configuration_view
 AS
SELECT
      history_id as history_id,
      storage_domain_id as storage_domain_id,
      storage_domain_name as storage_domain_name,
      storage_domain_type as storage_domain_type,
      storage_type as storage_type,
      create_date as create_date,
      update_date as update_date
FROM storage_domain_configuration
WHERE history_id in (SELECT max(a.history_id) FROM storage_domain_configuration as a GROUP BY a.storage_domain_id)
      and delete_date IS NULL;

CREATE OR REPLACE VIEW v3_1_storage_domain_samples_history_view
 AS
SELECT
      min(history_id) as history_id,
      history_datetime as history_datetime,
      storage_domain_id as storage_domain_id,
      max(available_disk_size_gb) as available_disk_size_gb,
      max(used_disk_size_gb) as used_disk_size_gb,
      max(storage_configuration_version) as storage_configuration_version
FROM storage_domain_samples_history
GROUP BY history_datetime, storage_domain_id;

CREATE OR REPLACE VIEW v3_1_storage_domain_hourly_history_view
 AS
SELECT
      min(history_id) as history_id,
      history_datetime as history_datetime,
      storage_domain_id as storage_domain_id,
      max(available_disk_size_gb) as available_disk_size_gb,
      max(used_disk_size_gb) as used_disk_size_gb,
      max(storage_configuration_version) as storage_configuration_version
FROM storage_domain_hourly_history
GROUP BY history_datetime, storage_domain_id;

CREATE OR REPLACE VIEW v3_1_storage_domain_daily_history_view
 AS
SELECT
      min(history_id) as history_id,
      history_datetime as history_datetime,
      storage_domain_id as storage_domain_id,
      max(available_disk_size_gb) as available_disk_size_gb,
      max(used_disk_size_gb) as used_disk_size_gb,
      max(storage_configuration_version) as storage_configuration_version
FROM storage_domain_daily_history
GROUP BY history_datetime, storage_domain_id;

CREATE OR REPLACE VIEW v3_1_cluster_configuration_view
 AS
SELECT
      history_id as history_id,
      cluster_id as cluster_id,
      cluster_name as cluster_name,
      cluster_description as cluster_description,
      datacenter_id as datacenter_id,
      cpu_name as cpu_name,
      compatibility_version as compatibility_version,
      datacenter_configuration_version as datacenter_configuration_version,
      create_date as create_date,
      update_date as update_date,
      delete_date as delete_date
FROM cluster_configuration;

CREATE OR REPLACE VIEW v3_1_latest_cluster_configuration_view
 AS
SELECT
      history_id as history_id,
      cluster_id as cluster_id,
      cluster_name as cluster_name,
      cluster_description as cluster_description,
      datacenter_id as datacenter_id,
      cpu_name as cpu_name,
      compatibility_version as compatibility_version,
      datacenter_configuration_version as datacenter_configuration_version,
      create_date as create_date,
      update_date as update_date
FROM cluster_configuration
WHERE history_id in (SELECT max(a.history_id) FROM cluster_configuration as a GROUP BY a.cluster_id)
      and delete_date IS NULL;

CREATE OR REPLACE VIEW v3_1_host_configuration_view
 AS
SELECT
      history_id as history_id,
      host_id as host_id,
      host_unique_id as host_unique_id,
      host_name as host_name,
      cluster_id as cluster_id,
      host_type as host_type,
      fqdn_or_ip as fqdn_or_ip,
      memory_size_mb as memory_size_mb,
      swap_size_mb as swap_size_mb,
      cpu_model as cpu_model,
      number_of_cores as number_of_cores,
      number_of_sockets,
      cpu_speed_mh,
      host_os as host_os,
      pm_ip_address as pm_ip_address,
      kernel_version as kernel_version,
      kvm_version as kvm_version,
      CASE SUBSTR(vdsm_version,1,3)
        WHEN '4.4' THEN '2.1' || SUBSTR(vdsm_version,4,LENGTH(vdsm_version))
        WHEN '4.5' THEN '2.2' || SUBSTR(vdsm_version,4,LENGTH(vdsm_version))
        WHEN '4.9' THEN '2.3' || SUBSTR(vdsm_version,4,LENGTH(vdsm_version))
      ELSE vdsm_version
      END as vdsm_version,
      vdsm_port as vdsm_port,
      cluster_configuration_version as cluster_configuration_version,
      create_date as create_date,
      update_date as update_date,
      delete_date as delete_date
FROM host_configuration;

CREATE OR REPLACE VIEW v3_1_latest_host_configuration_view
 AS
SELECT
      history_id as history_id,
      host_id as host_id,
      host_unique_id as host_unique_id,
      host_name as host_name,
      cluster_id as cluster_id,
      host_type as host_type,
      fqdn_or_ip as fqdn_or_ip,
      memory_size_mb as memory_size_mb,
      swap_size_mb as swap_size_mb,
      cpu_model as cpu_model,
      number_of_cores as number_of_cores,
      number_of_sockets,
      cpu_speed_mh,
      host_os as host_os,
      pm_ip_address as pm_ip_address,
      kernel_version as kernel_version,
      kvm_version as kvm_version,
      CASE SUBSTR(vdsm_version,1,3)
        WHEN '4.4' THEN '2.1' || SUBSTR(vdsm_version,4,LENGTH(vdsm_version))
        WHEN '4.5' THEN '2.2' || SUBSTR(vdsm_version,4,LENGTH(vdsm_version))
        WHEN '4.9' THEN '2.3' || SUBSTR(vdsm_version,4,LENGTH(vdsm_version))
      ELSE vdsm_version
      END as vdsm_version,
      vdsm_port as vdsm_port,
      cluster_configuration_version as cluster_configuration_version,
      create_date as create_date,
      update_date as update_date
FROM host_configuration
WHERE history_id in (SELECT max(a.history_id) FROM host_configuration as a GROUP BY a.host_id)
      and delete_date IS NULL;

CREATE OR REPLACE VIEW v3_1_host_samples_history_view
 AS
SELECT
      history_id as history_id,
      history_datetime as history_datetime,
      host_id as host_id,
      host_status as host_status,
      minutes_in_status as minutes_in_status,
      memory_usage_percent as memory_usage_percent,
      cpu_usage_percent as cpu_usage_percent,
      ksm_cpu_percent as ksm_cpu_percent,
      active_vms as active_vms,
      total_vms as total_vms,
      total_vms_vcpus as total_vms_vcpus,
      cpu_load as cpu_load,
      system_cpu_usage_percent as system_cpu_usage_percent,
      user_cpu_usage_percent as user_cpu_usage_percent,
      swap_used_mb as swap_used_mb,
      host_configuration_version as host_configuration_version
FROM host_samples_history;

CREATE OR REPLACE VIEW v3_1_host_hourly_history_view
 AS
SELECT
      history_id as history_id,
      history_datetime as history_datetime,
      host_id as host_id,
      host_status as host_status,
      minutes_in_status as minutes_in_status,
      memory_usage_percent as memory_usage_percent,
      max_memory_usage as max_memory_usage,
      cpu_usage_percent as cpu_usage_percent,
      max_cpu_usage as max_cpu_usage,
      ksm_cpu_percent as ksm_cpu_percent,
      max_ksm_cpu_percent as max_ksm_cpu_percent,
      active_vms as active_vms,
      max_active_vms as max_active_vms,
      total_vms as total_vms,
      max_total_vms as max_total_vms,
      total_vms_vcpus as total_vms_vcpus,
      max_total_vms_vcpus as max_total_vms_vcpus,
      cpu_load as cpu_load,
      max_cpu_load as max_cpu_load,
      system_cpu_usage_percent as system_cpu_usage_percent,
      max_system_cpu_usage_percent as max_system_cpu_usage_percent,
      user_cpu_usage_percent as user_cpu_usage_percent,
      max_user_cpu_usage_percent as max_user_cpu_usage_percent,
      swap_used_mb as swap_used_mb,
      max_swap_used_mb as max_swap_used_mb,
      host_configuration_version as host_configuration_version
FROM host_hourly_history;

CREATE OR REPLACE VIEW v3_1_host_daily_history_view
 AS
SELECT
      history_id as history_id,
      history_datetime as history_datetime,
      host_id as host_id,
      host_status as host_status,
      minutes_in_status as minutes_in_status,
      memory_usage_percent as memory_usage_percent,
      max_memory_usage as max_memory_usage,
      cpu_usage_percent as cpu_usage_percent,
      max_cpu_usage as max_cpu_usage,
      ksm_cpu_percent as ksm_cpu_percent,
      max_ksm_cpu_percent as max_ksm_cpu_percent,
      active_vms as active_vms,
      max_active_vms as max_active_vms,
      total_vms as total_vms,
      max_total_vms as max_total_vms,
      total_vms_vcpus as total_vms_vcpus,
      max_total_vms_vcpus as max_total_vms_vcpus,
      cpu_load as cpu_load,
      max_cpu_load as max_cpu_load,
      system_cpu_usage_percent as system_cpu_usage_percent,
      max_system_cpu_usage_percent as max_system_cpu_usage_percent,
      user_cpu_usage_percent as user_cpu_usage_percent,
      max_user_cpu_usage_percent as max_user_cpu_usage_percent,
      swap_used_mb as swap_used_mb,
      max_swap_used_mb as max_swap_used_mb,
      host_configuration_version as host_configuration_version
FROM host_daily_history;

CREATE OR REPLACE VIEW v3_1_host_interface_configuration_view
 AS
SELECT
      history_id as history_id,
      host_interface_id as host_interface_id,
      host_interface_name as host_interface_name,
      host_id as host_id,
      host_interface_type as host_interface_type,
      host_interface_speed_bps as host_interface_speed_bps,
      mac_address as mac_address,
      logical_network_name as network_name,
      ip_address as ip_address,
      gateway as gateway,
      bond as bond,
      bond_name as bond_name,
      vlan_id as vlan_id,
      host_configuration_version as host_configuration_version,
      create_date as create_date,
      update_date as update_date,
      delete_date as delete_date
FROM host_interface_configuration;

CREATE OR REPLACE VIEW v3_1_latest_host_interface_configuration_view
 AS
SELECT
      history_id as history_id,
      host_interface_id as host_interface_id,
      host_interface_name as host_interface_name,
      host_id as host_id,
      host_interface_type as host_interface_type,
      host_interface_speed_bps as host_interface_speed_bps,
      mac_address as mac_address,
      logical_network_name as network_name,
      ip_address as ip_address,
      gateway as gateway,
      bond as bond,
      bond_name as bond_name,
      vlan_id as vlan_id,
      host_configuration_version as host_configuration_version,
      create_date as create_date,
      update_date as update_date
FROM host_interface_configuration
WHERE history_id in (SELECT max(a.history_id) FROM host_interface_configuration as a GROUP BY a.host_interface_id)
      and delete_date IS NULL;

CREATE OR REPLACE VIEW v3_1_host_interface_samples_history_view
 AS
SELECT
      history_id as history_id,
      history_datetime as history_datetime,
      host_interface_id as host_interface_id,
      receive_rate_percent as receive_rate_percent,
      transmit_rate_percent as transmit_rate_percent,
      host_interface_configuration_version as host_interface_configuration_version
FROM host_interface_samples_history;

CREATE OR REPLACE VIEW v3_1_host_interface_hourly_history_view
 AS
SELECT
      history_id as history_id,
      history_datetime as history_datetime,
      host_interface_id as host_interface_id,
      receive_rate_percent as receive_rate_percent,
      max_receive_rate_percent as max_receive_rate_percent,
      transmit_rate_percent as transmit_rate_percent,
      max_transmit_rate_percent as max_transmit_rate_percent,
      host_interface_configuration_version as host_interface_configuration_version
FROM host_interface_hourly_history;

CREATE OR REPLACE VIEW v3_1_host_interface_daily_history_view
 AS

SELECT
      history_id as history_id,
      history_datetime as history_datetime,
      host_interface_id as host_interface_id,
      receive_rate_percent as receive_rate_percent,
      max_receive_rate_percent as max_receive_rate_percent,
      transmit_rate_percent as transmit_rate_percent,
      max_transmit_rate_percent as max_transmit_rate_percent,
      host_interface_configuration_version as host_interface_configuration_version
FROM host_interface_daily_history;

CREATE OR REPLACE VIEW v3_1_vm_configuration_view
 AS
SELECT
      history_id as history_id,
      vm_id as vm_id,
      vm_name as vm_name,
      vm_description as vm_description,
      vm_type as vm_type,
      cluster_id as cluster_id,
      template_id as template_id,
      template_name as template_name,
      cpu_per_socket as cpu_per_socket,
      number_of_sockets as number_of_sockets,
      memory_size_mb as memory_size_mb,
      operating_system as operating_system,
      cast(NULL as VARCHAR(40)) as ad_domain,
      default_host as default_host,
      high_availability as high_availability,
      initialized as initialized,
      stateless as stateless,
      fail_back as fail_back,
      FALSE as auto_suspend,
      usb_policy as usb_policy,
      time_zone as time_zone,
      cluster_configuration_version as cluster_configuration_version,
      default_host_configuration_version as default_host_configuration_version,
      create_date as create_date,
      update_date as update_date,
      delete_date as delete_date
FROM vm_configuration;

CREATE OR REPLACE VIEW v3_1_latest_vm_configuration_view
 AS
SELECT
      history_id as history_id,
      vm_id as vm_id,
      vm_name as vm_name,
      vm_description as vm_description,
      vm_type as vm_type,
      cluster_id as cluster_id,
      template_id as template_id,
      template_name as template_name,
      cpu_per_socket as cpu_per_socket,
      number_of_sockets as number_of_sockets,
      memory_size_mb as memory_size_mb,
      operating_system as operating_system,
      cast(NULL as VARCHAR(40)) as ad_domain,
      default_host as default_host,
      high_availability as high_availability,
      initialized as initialized,
      stateless as stateless,
      fail_back as fail_back,
      FALSE as auto_suspend,
      usb_policy as usb_policy,
      time_zone as time_zone,
      cluster_configuration_version as cluster_configuration_version,
      default_host_configuration_version as default_host_configuration_version,
      create_date as create_date,
      update_date as update_date
FROM vm_configuration
WHERE history_id in (SELECT max(a.history_id) FROM vm_configuration as a GROUP BY a.vm_id)
      and delete_date IS NULL;

CREATE OR REPLACE VIEW v3_1_vm_samples_history_view
 AS
SELECT
    a.history_id as history_id,
    a.history_datetime as history_datetime,
    a.vm_id as vm_id,
    a.vm_status as vm_status,
    a.minutes_in_status as minutes_in_status,
    a.cpu_usage_percent as cpu_usage_percent,
    a.memory_usage_percent as memory_usage_percent,
    a.user_cpu_usage_percent as user_cpu_usage_percent,
    a.system_cpu_usage_percent as system_cpu_usage_percent,
    cast(a.vm_ip as varchar(255)) as vm_ip,
    a.currently_running_on_host as currently_running_on_host,
    COALESCE(users.username, a.current_user_name) as current_user_name,
    b.disks_usage as disks_usage,
    a.vm_configuration_version as vm_configuration_version,
    a.current_host_configuration_version as current_host_configuration_version
FROM vm_samples_history as a
    LEFT OUTER JOIN vm_disks_usage_samples_history as b
        ON (a.history_datetime = b.history_datetime AND a.vm_id = b.vm_id)
    LEFT OUTER JOIN users_details_history as users
        ON (a.current_user_id = users.user_id);

CREATE OR REPLACE VIEW v3_1_vm_hourly_history_view
 AS
SELECT
    a.history_id as history_id,
    a.history_datetime as history_datetime,
    a.vm_id as vm_id,
    a.vm_status as vm_status,
    a.minutes_in_status as minutes_in_status,
    a.cpu_usage_percent as cpu_usage_percent,
    a.max_cpu_usage as max_cpu_usage,
    a.memory_usage_percent as memory_usage_percent,
    a.max_memory_usage as max_memory_usage,
    a.user_cpu_usage_percent as user_cpu_usage_percent,
    a.max_user_cpu_usage_percent as max_user_cpu_usage_percent,
    a.system_cpu_usage_percent as system_cpu_usage_percent,
    a.max_system_cpu_usage_percent as max_system_cpu_usage_percent,
    cast(a.vm_ip as varchar(255)) as vm_ip,
    a.currently_running_on_host as currently_running_on_host,
    COALESCE(users.username, a.current_user_name) as current_user_name,
    b.disks_usage as disks_usage,
    a.vm_configuration_version as vm_configuration_version,
    a.current_host_configuration_version as current_host_configuration_version
FROM vm_hourly_history as a
    LEFT OUTER JOIN vm_disks_usage_hourly_history as b
        ON (a.history_datetime = b.history_datetime AND a.vm_id = b.vm_id)
    LEFT OUTER JOIN users_details_history as users
        ON (a.current_user_id = users.user_id);

CREATE OR REPLACE VIEW v3_1_vm_daily_history_view
 AS
SELECT
    a.history_id as history_id,
    a.history_datetime as history_datetime,
    a.vm_id as vm_id,
    a.vm_status as vm_status,
    a.minutes_in_status as minutes_in_status,
    a.cpu_usage_percent as cpu_usage_percent,
    a.max_cpu_usage as max_cpu_usage,
    a.memory_usage_percent as memory_usage_percent,
    a.max_memory_usage as max_memory_usage,
    a.user_cpu_usage_percent as user_cpu_usage_percent,
    a.max_user_cpu_usage_percent as max_user_cpu_usage_percent,
    a.system_cpu_usage_percent as system_cpu_usage_percent,
    a.max_system_cpu_usage_percent as max_system_cpu_usage_percent,
    cast(a.vm_ip as varchar(255)) as vm_ip,
    a.currently_running_on_host as currently_running_on_host,
    COALESCE(users.username, a.current_user_name) as current_user_name,
    b.disks_usage as disks_usage,
    a.vm_configuration_version as vm_configuration_version,
    a.current_host_configuration_version as current_host_configuration_version
FROM vm_daily_history as a
    LEFT OUTER JOIN vm_disks_usage_daily_history as b
        ON (a.history_datetime = b.history_datetime AND a.vm_id = b.vm_id)
    LEFT OUTER JOIN users_details_history as users
        ON (a.current_user_id = users.user_id);

CREATE OR REPLACE VIEW v3_1_vm_interface_configuration_view
 AS
SELECT
      history_id as history_id,
      vm_interface_id as vm_interface_id,
      vm_interface_name as vm_interface_name,
      vm_interface_type as vm_interface_type,
      vm_interface_speed_bps as vm_interface_speed_bps,
      mac_address as mac_address,
      logical_network_name as network_name,
      vm_configuration_version as vm_configuration_version,
      create_date as create_date,
      update_date as update_date,
      delete_date as delete_date
FROM vm_interface_configuration;

CREATE OR REPLACE VIEW v3_1_latest_vm_interface_configuration_view
 AS
SELECT
      history_id as history_id,
      vm_interface_id as vm_interface_id,
      vm_interface_name as vm_interface_name,
      vm_interface_type as vm_interface_type,
      vm_interface_speed_bps as vm_interface_speed_bps,
      mac_address as mac_address,
      logical_network_name as network_name,
      vm_configuration_version as vm_configuration_version,
      create_date as create_date,
      update_date as update_date
FROM vm_interface_configuration
WHERE history_id in (SELECT max(a.history_id) FROM vm_interface_configuration as a GROUP BY a.vm_interface_id)
      and delete_date IS NULL;

CREATE OR REPLACE VIEW v3_1_vm_interface_samples_history_view
 AS

SELECT
      history_id as history_id,
      history_datetime as history_datetime,
      vm_interface_id as vm_interface_id,
      receive_rate_percent as receive_rate_percent,
      transmit_rate_percent as transmit_rate_percent,
      vm_interface_configuration_version as vm_interface_configuration_version
FROM vm_interface_samples_history;

CREATE OR REPLACE VIEW v3_1_vm_interface_hourly_history_view
 AS

SELECT
      history_id as history_id,
      history_datetime as history_datetime,
      vm_interface_id as vm_interface_id,
      receive_rate_percent as receive_rate_percent,
      max_receive_rate_percent as max_receive_rate_percent,
      transmit_rate_percent as transmit_rate_percent,
      max_transmit_rate_percent as max_transmit_rate_percent,
      vm_interface_configuration_version as vm_interface_configuration_version
FROM vm_interface_hourly_history;

CREATE OR REPLACE VIEW v3_1_vm_interface_daily_history_view
 AS

SELECT
      history_id as history_id,
      history_datetime as history_datetime,
      vm_interface_id as vm_interface_id,
      receive_rate_percent as receive_rate_percent,
      max_receive_rate_percent as max_receive_rate_percent,
      transmit_rate_percent as transmit_rate_percent,
      max_transmit_rate_percent as max_transmit_rate_percent,
      vm_interface_configuration_version as vm_interface_configuration_version
FROM vm_interface_daily_history;

CREATE OR REPLACE VIEW v3_1_vm_disk_configuration_view
 AS
SELECT
    history_id as history_id,
    vm_disk_id as vm_disk_id,
    CASE
          WHEN vm_disk_name IS NOT NULL THEN vm_disk_name
          ELSE 'disk ' || cast(vm_internal_drive_mapping as varchar)
    END as vm_disk_name,
    vm_disk_description as vm_disk_description,
    image_id as image_id,
    storage_domain_id as storage_domain_id,
    vm_disk_size_mb as vm_disk_size_mb,
    vm_disk_type as vm_disk_type,
    vm_disk_format as vm_disk_format,
    vm_disk_interface as vm_disk_interface,
    is_shared as is_shared,
    create_date as create_date,
    update_date as update_date,
    delete_date as delete_date
FROM vm_disk_configuration;

CREATE OR REPLACE VIEW v3_1_latest_vm_disk_configuration_view
 AS
SELECT
    history_id as history_id,
    vm_disk_id as vm_disk_id,
    CASE
          WHEN vm_disk_name IS NOT NULL THEN vm_disk_name
          ELSE 'disk ' || cast(vm_internal_drive_mapping as varchar)
    END as vm_disk_name,
    vm_disk_description as vm_disk_description,
    image_id as image_id,
    storage_domain_id as storage_domain_id,
    vm_disk_size_mb as vm_disk_size_mb,
    vm_disk_type as vm_disk_type,
    vm_disk_format as vm_disk_format,
    vm_disk_interface as vm_disk_interface,
    is_shared as is_shared,
    create_date as create_date,
    update_date as update_date
FROM vm_disk_configuration
WHERE history_id in (SELECT max(a.history_id) FROM vm_disk_configuration as a GROUP BY a.vm_disk_id)
      and delete_date IS NULL;

CREATE OR REPLACE VIEW v3_1_vm_disk_samples_history_view
 AS
SELECT
    history_id as history_id,
    history_datetime as history_datetime,
    vm_disk_id as vm_disk_id,
    vm_disk_status as vm_disk_status,
    minutes_in_status as minutes_in_status,
    vm_disk_actual_size_mb as vm_disk_actual_size_mb,
    read_rate_bytes_per_second as read_rate_bytes_per_second,
    read_latency_seconds as read_latency_seconds,
    write_rate_bytes_per_second as write_rate_bytes_per_second,
    write_latency_seconds as write_latency_seconds,
    flush_latency_seconds as flush_latency_seconds,
    vm_disk_configuration_version as vm_disk_configuration_version
FROM vm_disk_samples_history;

CREATE OR REPLACE VIEW v3_1_vm_disk_hourly_history_view
 AS
SELECT
    history_id as history_id,
    history_datetime as history_datetime,
    vm_disk_id as vm_disk_id,
    vm_disk_status as vm_disk_status,
    minutes_in_status as minutes_in_status,
    vm_disk_actual_size_mb as vm_disk_actual_size_mb,
    read_rate_bytes_per_second as read_rate_bytes_per_second,
    max_read_rate_bytes_per_second as max_read_rate_bytes_per_second,
    read_latency_seconds as read_latency_seconds,
    max_read_latency_seconds as max_read_latency_seconds,
    write_rate_bytes_per_second as write_rate_bytes_per_second,
    max_write_rate_bytes_per_second as max_write_rate_bytes_per_second,
    write_latency_seconds as write_latency_seconds,
    max_write_latency_seconds as max_write_latency_seconds,
    flush_latency_seconds as flush_latency_seconds,
    max_flush_latency_seconds as max_flush_latency_seconds,
    vm_disk_configuration_version as vm_disk_configuration_version
FROM vm_disk_hourly_history;

CREATE OR REPLACE VIEW v3_1_vm_disk_daily_history_view
 AS
SELECT
    history_id as history_id,
    history_datetime as history_datetime,
    vm_disk_id as vm_disk_id,
    vm_disk_status as vm_disk_status,
    minutes_in_status as minutes_in_status,
    vm_disk_actual_size_mb as vm_disk_actual_size_mb,
    read_rate_bytes_per_second as read_rate_bytes_per_second,
    max_read_rate_bytes_per_second as max_read_rate_bytes_per_second,
    read_latency_seconds as read_latency_seconds,
    max_read_latency_seconds as max_read_latency_seconds,
    write_rate_bytes_per_second as write_rate_bytes_per_second,
    max_write_rate_bytes_per_second as max_write_rate_bytes_per_second,
    write_latency_seconds as write_latency_seconds,
    max_write_latency_seconds as max_write_latency_seconds,
    flush_latency_seconds as flush_latency_seconds,
    max_flush_latency_seconds as max_flush_latency_seconds,
    vm_disk_configuration_version as vm_disk_configuration_version
FROM vm_disk_daily_history;

CREATE OR REPLACE VIEW v3_1_vm_device_history_view
 AS
SELECT
    history_id as history_id,
    vm_id,
    device_id,
    type,
    address,
    is_managed,
    is_plugged,
    is_readonly,
    vm_configuration_version,
    device_configuration_version,
    create_date,
    update_date,
    delete_date
FROM vm_device_history;

CREATE OR REPLACE VIEW v3_1_latest_vm_device_history_view
 AS
SELECT
    history_id as history_id,
    vm_id,
    device_id,
    type,
    address,
    is_managed,
    is_plugged,
    is_readonly,
    vm_configuration_version,
    device_configuration_version,
    create_date,
    update_date
FROM vm_device_history
WHERE history_id in (SELECT max(a.history_id) FROM vm_device_history as a GROUP BY a.vm_id, a.device_id)
      and delete_date IS NULL;

CREATE OR REPLACE VIEW v3_1_tag_relations_history_view
 AS
SELECT    history_id as history_id,
        entity_id as entity_id,
        entity_type as entity_type,
        parent_id as parent_id,
        attach_date as attach_date,
        detach_date as detach_date
FROM         tag_relations_history
WHERE       entity_type in(3,2,5,18);

CREATE OR REPLACE VIEW v3_1_latest_tag_relations_history_view
 AS
SELECT    history_id as history_id,
        entity_id as entity_id,
        entity_type as entity_type,
        parent_id as parent_id,
        attach_date as attach_date,
        detach_date as detach_date
FROM         tag_relations_history
WHERE       entity_type in(3,2,5,18)
       and history_id in (SELECT max(a.history_id) FROM tag_relations_history as a GROUP BY a.entity_id, a.parent_id)
       and detach_date IS NULL;

CREATE OR REPLACE VIEW v3_1_tag_details_view
 AS
SELECT  history_id as history_id,
        tag_id as tag_id,
        tag_name as tag_name,
        tag_description as tag_description,
        tag_path as tag_path,
        tag_level as tag_level,
        create_date as create_date,
        update_date as update_date,
        delete_date as delete_date
FROM         tag_details;

CREATE OR REPLACE VIEW v3_1_latest_tag_details_view
 AS
SELECT  history_id as history_id,
        tag_id as tag_id,
        tag_name as tag_name,
        tag_description as tag_description,
        tag_path as tag_path,
        tag_level as tag_level,
        create_date as create_date,
        update_date as update_date,
        delete_date as delete_date
FROM         tag_details
WHERE history_id in (SELECT max(a.history_id) FROM tag_details as a GROUP BY a.tag_id)
      and delete_date IS NULL;

