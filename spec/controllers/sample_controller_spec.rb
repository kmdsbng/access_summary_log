# -*- encoding: utf-8 -*-
require File.dirname(__FILE__) + "/../spec_helper"
require 'fileutils'

describe SampleController do
  describe 'output log' do
    it 'responds status 200' do
      get :sample_action
      expect(response.status).to eq(200)
    end

    it 'responds body' do
      get :sample_action
      expect(response.body).to eq('hoge')
    end

    context 'check log' do
      before do
        @log_file_path = File.dirname(__FILE__) + '/../dummy/log/access_summary.log'
        FileUtils.rm @log_file_path rescue nil
      end

      it 'output access_summary.log' do
        log = File.read(@log_file_path) rescue ''
        log.should be_blank
        get :sample_action
        log = File.read(@log_file_path) rescue ''
        log.should be_present
      end

      it 'output 200 OK' do
        get :sample_action
        log = File.read(@log_file_path) rescue ''
        log.should be_include("200 OK")
      end
    end
  end
end


