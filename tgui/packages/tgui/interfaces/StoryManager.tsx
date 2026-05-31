// THIS IS A SKYRAT UI FILE
import {
  Button,
  Collapsible,
  LabeledList,
  Section,
  TextArea,
} from 'tgui-core/components';

import { useBackend, useLocalState } from '../backend';
import { Window } from '../layouts';

type StoryManagerData = {
  current_stories: Story[];
  archived_stories: Story[];
  current_date: string;
};

type Story = {
  title: string;
  text: string;
  id: string;
  year: string;
  month: string;
  day: string;
};

export const StoryManager = (props) => {
  const { data, act } = useBackend<StoryManagerData>();
  const { current_stories, archived_stories, current_date } = data;

  const [title, setTitle] = useLocalState('title', '');
  const [text, setText] = useLocalState('text', '');
  const [id, setID] = useLocalState('id', '');

  return (
    <Window width={600} height={800} title="Gerente de Lorecaster">
      <Window.Content scrollable>
        <Section textAlign="center">
          Lorecaster story manager
          <br />
          <i>Anything published here will not appear until the next round!</i>
          <br />
          <span style={{ color: 'red' }}>
            Do not mess with this unless you know what you&apos;re doing.
          </span>
        </Section>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Title">
              <TextArea
                height="20px"
                placeholder="Um curto, consiste título/autor para o artigo."
                onChange={setTitle}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Texto do Corpo">
              <TextArea
                height="100px"
                placeholder="O conteúdo do artigo em si."
                onChange={setText}
              />
            </LabeledList.Item>
            <LabeledList.Item label="ID">
              <TextArea
                height="20px"
                placeholder="Uma identidade única para o artigo. O artigo não publicará se a identificação estiver em uso."
                onChange={setID}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Date">
              <i>Publishing Date: {current_date}</i>
            </LabeledList.Item>
          </LabeledList>
          <Button
            icon="arrow-up"
            mr="9px"
            color="blue"
            onClick={() => {
              act('publish_article', {
                title: title,
                text: text,
                id: id,
              });
            }}
          >
            Publish
          </Button>
        </Section>
        <Collapsible title="Histórias atuais">
          {current_stories.map((story) => (
            <Collapsible
              bold
              key={story.id}
              title={
                story.title +
                'Publicado' +
                story.month +
                '/' +
                story.day +
                '/' +
                story.year
              }
            >
              <Section>
                {story.text}
                <br />
                <Button
                  icon="book"
                  mr="9px"
                  color="red"
                  onClick={() => {
                    act('archive_article', {
                      id: story.id,
                    });
                  }}
                >
                  Archive
                </Button>
              </Section>
            </Collapsible>
          ))}
        </Collapsible>
        <Collapsible title="Histórias Arquivadas">
          {archived_stories.map((story) => (
            <Collapsible
              bold
              key={story.id}
              title={
                story.title +
                'Publicado' +
                story.month +
                '/' +
                story.day +
                '/' +
                story.year
              }
            >
              <Section>
                {story.text}
                <br />
                <Button
                  icon="floppy-disk"
                  mr="9px"
                  color="green"
                  onClick={() => {
                    act('circulate_article', {
                      id: story.id,
                    });
                  }}
                >
                  Circulate
                </Button>
              </Section>
            </Collapsible>
          ))}
        </Collapsible>
      </Window.Content>
    </Window>
  );
};
