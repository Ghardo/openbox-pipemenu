#!/usr/bin/env ruby
# encoding: UTF-8

require 'nokogiri'

module Openbox
	module Pipemenu
		module NormalizeNodeId
			def id=(value)
				if value != nil
					@id = value
				else
					@id = label.downcase.gsub(' ', '_').gsub(/[^A-Za-z0-9]/, '')
				end
			end
		end

		class Element
			attr_accessor :icon, :label, :id

			def node
				return @node unless @node == nil

				doc = Nokogiri::XML::Document.new
				@node = Nokogiri::XML::Node.new @type, doc

				@node['id'] = @id unless @id == nil
				@node['label'] = @label unless @label == nil
				@node['icon'] = @icon unless @icon == nil

				if self.kind_of? Item
					if @command != nil
						action = Nokogiri::XML::Node.new 'action', doc
						action['name'] = 'Execute'

						command = Nokogiri::XML::Node.new 'execute', doc
						command.content = @command
						action.add_child command

						@node.add_child action
					elsif @menu != nil
						action = Nokogiri::XML::Node.new 'action', doc
						action['name'] = 'ShowMenu'

						menu = Nokogiri::XML::Node.new 'menu', doc
						menu.content = @menu
						action.add_child menu

						@node.add_child action
					end
				end

				@node
			end

			def add(element)
				self.node.add_child element.node
			end
		end

		class Pipemenu
			attr_accessor :doc
			def initialize
				@doc = Nokogiri::XML::Document.new
				@node = Nokogiri::XML::Node.new 'openbox_pipe_menu', @doc
				@doc.add_child @node
			end

			def add(element)
				@node.add_child element.node
			end

			def to_s
				@node.to_xml
			end
		end

		class Menu < Element
			include NormalizeNodeId

			def initialize(label, id = nil)
				@type = 'menu'
				@label = label
				self.id = id
			end
		end

		class Item < Element
			include NormalizeNodeId
			attr_accessor :command, :menu

			def initialize(label, id = nil)
				@type = 'item'
				@label = label
				self.id = id
			end
		end

		class Separator < Element
			def initialize(label)
				@type = 'separator'
				@label = label
			end
		end
	end
end
