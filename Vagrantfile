# -*- mode: ruby -*-
# vi: set ft=ruby :

# createNode(obj)
# obj{quantity,cpus,memory}

require 'fileutils'
require "yaml"

vagrant_root = File.dirname(File.expand_path(__FILE__))
cluster_config_data = YAML.load_file "#{vagrant_root}/cluster_config.yaml"
cc = cluster_config_data["cluster_config"]
@cp = 61000

CLUSTER_NAME = cc["name"].strip

BOX_NAME = "ubuntu/focal64"
SHARED_PATH = "shared"
SCRIPTS_PATH = "scripts"

#CLUSTER_NAME="k8smd1000"
#IP_NW="192.168.56."
#IP_START="2"
#PORTS=[57620,53654,51234]

nodes = cc["nodes"]

def get_next_ip(ip_address)
  # Divide o endereço IP em octetos separados
  octets = ip_address.split('.')
  
  # Converte o último octeto em um número inteiro e aumenta em 1
  last_octet = octets.last.to_i + 1
 
  if last_octet == 1 
    last_octet += 1
  end
 
  # Verifica se o último octeto não ultrapassou 255
  last_octet = 0 if last_octet > 255
  
  # Atualiza o último octeto no array de octetos
  octets[-1] = last_octet.to_s
  
  # Retorna o endereço IP modificado
  octets.join('.')
end

def is_network_in_list(network, list)
  #puts "list: #{list}"

  if !list.kind_of?(Array)
    return false
  end

  list.each do | net |
    if net == network
      return true
    end
  end  

  return false
end

def config_node_ports(cc, cp, machine, node_params)
  #current_port = 61000
  ports = {}

  #puts cp

  # [guest]:[host]
  cluster_ports = cc["ports"]
  if cluster_ports
    cluster_ports.each do | p |
      ports[@cp] = p
      @cp += 1
    end
  end

  node_ports = node_params["ports"]
  if node_ports
    node_ports.each do | p |
      parts = p.split(":")
      ports[parts[0]] = parts[1]
    end
  end

  #puts ports

  ports.each do | host, guest |
    machine.vm.network "forwarded_port", guest: guest, host: host 
  end  
end

def config_node_networks(cc, machine, node_params)
  networks = cc["networks"]
  #puts networks
  networks.each do | net_name, settings |
    #puts net_name
    #puts settings
    #puts node_params
    next if !is_network_in_list(net_name, node_params["networks"]) && net_name != "default"  
    settings["network"] = get_next_ip(settings["network"]) 
    machine.vm.network "private_network", ip: settings["network"]
    #puts settings["network"]
  end
end

def exec_functions(cc, machine, node_params)

end

def config_node_provisions(cc, machine, params, role)
  scripts_folder = "scripts"
 
  common_scripts = cc["scripts"]

  if common_scripts
    common_scripts.each do | s |
      machine.vm.provision "#{s}", privileged: true, type: "shell", path: "./#{SCRIPTS_PATH}/#{s}"
    end
  end
 
  scripts = params["scripts"]

  if scripts
    scripts.each do | s |
      machine.vm.provision "#{s}", privileged: true, type: "shell", path: "./#{SCRIPTS_PATH}/#{s}"
    end
  end
end

def config_node_folders(cc, machine, params)
  machine.vm.synced_folder (SHARED_PATH + "/"), "/#{SHARED_PATH}"
  machine.vm.synced_folder (SCRIPTS_PATH + "/"), "/#{SHARED_PATH}/#{SCRIPTS_PATH}"
 
  folders_path = "folders"
 
  folders = params["folders"]
  if folders
    folders.each do | f |
      host_path = folders_path + "/" + f + "/"
      unless File.directory?(host_path)
        FileUtils.mkdir_p(host_path)
      end
      mount_path = "/" + f
      machine.vm.synced_folder host_path, mount_path
    end
  end
end

def create_machine(config, cc, node, cp)
  role = node[0]
  params = node[1]
  
  #puts "Node_role: #{role}"
  #puts "params: #{params}"

  (0..(params["quantity"]-1)).each do |i|
    #hostname = "#{CLUSTER_NAME}-#{role}-#{i}"
    #hostname = "#{CLUSTER_NAME}#{role}#{i}"
    hostname = "#{CLUSTER_NAME}-#{role}-#{i}"   

    puts "#{hostname}"
 
    config.vm.define "#{hostname}" do |machine|
      machine.vm.provider "virtualbox" do |vb|
        vb.name = "#{hostname}"
        vb.cpus = params["cpus"]
        vb.memory = params["memory"]
      end
      machine.vm.hostname = "#{hostname}"
      config_node_networks(cc, machine, params)
      config_node_ports(cc, @cp, machine, params)
      config_node_provisions(cc, machine, params, role)
      config_node_folders(cc, machine, params)
      #exec_functions(cc, machine, params)
    end 
  end
end

##################################
##       VAGRANT FUNCTION       ##
##################################
Vagrant.configure("2") do |config|
  config.vm.box = BOX_NAME
  config.vm.box_check_update = false
  
  nodes.each do | node |
    create_machine(config, cc, node, @cp)
  end
end

