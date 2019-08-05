# frozen_string_literal: true

json.array! @attachments, partial: 'attachments/attachment', as: :attachment
