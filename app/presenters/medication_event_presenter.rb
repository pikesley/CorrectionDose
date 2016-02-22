class MedicationEventPresenter < GenericPresenter
  def edit_cell
    cell(link_to model.datetime.strftime('%H:%M'),
    url_helpers.edit_medication_event_path(model),
    title: 'Edit this meds')
  end

  def measurement_cell
    cell value_div, 'glucose-measurement-value'
  end

  def number_span
    super :dose
  end

  def value_div
    super :dose
  end

  def measurement_cell
    cell value_div, 'medication-event-dose'
  end

  def meds_cell
    cell model.insulin, 'medication-event-insulin'
  end

  def to_tr padding: 0
    super [
      edit_cell,
      label_cell,
      measurement_cell,
      meds_cell
    ]
  end

  def units
    {
      full: 'Insulin units',
      short: 'u'
    }
  end
end
