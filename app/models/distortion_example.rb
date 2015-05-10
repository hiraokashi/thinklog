# -*- coding: utf-8 -*-
class DistortionExample < ActiveRecord::Base

 belongs_to :congitive_diagnosis #認知の歪み診断に所属する


  #バリデーション追加
  #validates :permalink, presence: true, uniqueness: true, length: {maximum: 64}
  #validates :title, presence: true, length: {maximum: 128}
  # validates :content, presence: true
end
